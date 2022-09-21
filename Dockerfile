ARG BASE_IMAGE=jupyter/minimal-notebook
FROM $BASE_IMAGE

# Create the build image.

ARG SENZING_ACCEPT_EULA="I_ACCEPT_THE_SENZING_EULA"
ARG SENZING_APT_INSTALL_PACKAGE="senzingapi-runtime=3.2.0-22234"
ARG SENZING_APT_INSTALL_TOOLS_PACKAGE="senzingapi-tools=3.2.0-22234"
ARG SENZING_APT_REPOSITORY_NAME="senzingrepo_1.0.1-1_amd64.deb"
ARG SENZING_APT_REPOSITORY_URL="https://senzing-production-apt.s3.amazonaws.com"

ENV REFRESHED_AT=2022-09-15

ENV SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
    SENZING_APT_INSTALL_PACKAGE=${SENZING_APT_INSTALL_PACKAGE} \
    SENZING_APT_INSTALL_TOOLS_PACKAGE=${SENZING_APT_INSTALL_TOOLS_PACKAGE} \
    SENZING_APT_REPOSITORY_NAME=${SENZING_APT_REPOSITORY_NAME} \
    SENZING_APT_REPOSITORY_URL=${SENZING_APT_REPOSITORY_URL}

LABEL Name="senzing/senzing-tutorial-in-python" \
      Maintainer="support@senzing.com" \
      Version="0.0.0"

# Run as "root" for system installation.

USER root

# Install packages via apt.

RUN apt-get update \
 && apt-get -y install \
        wget

# Install Senzing repository index.

RUN wget -qO \
        /${SENZING_APT_REPOSITORY_NAME} \
        ${SENZING_APT_REPOSITORY_URL}/${SENZING_APT_REPOSITORY_NAME} \
 && apt-get -y install \
        /${SENZING_APT_REPOSITORY_NAME} \
 && apt-get update \
 && rm /${SENZING_APT_REPOSITORY_NAME}

# download and install binary openssl packages for libssl1.1 required by senzing
RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
 && dpkg -i ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb \
 && rm -rf ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb

# Install Senzing package.

RUN apt-get -y install \
      libpq5 \
      python3-psycopg2 \
      ${SENZING_APT_INSTALL_PACKAGE} \
      ${SENZING_APT_INSTALL_TOOLS_PACKAGE} \
 && apt-get clean

# Copy files from repository.

COPY ./rootfs /
COPY ./senzing-examples/python /home/${NB_USER}/senzing-examples
COPY ./senzing-tutorials /home/${NB_USER}/senzing-tutorials
RUN rmdir /home/${NB_USER}/work \
 && fix-permissions "/home/${NB_USER}" \
 && fix-permissions "/var/opt/senzing"

# switch to the jupyter labs user

USER $NB_UID

# Set environment variables for $NB_UID.

ENV LANGUAGE=C \
    LC_ALL=C.UTF-8 \
    LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/senzing/g2/lib \
    PATH=${PATH}:/opt/senzing/g2/python \
    PYTHONPATH=${PYTHONPATH}/opt/senzing/g2/python:/opt/senzing/g2/sdk/python \
    PYTHONUNBUFFERED=1 \
    SENZING_DOCKER_LAUNCHED=true \
    SENZING_ENGINE_CONFIGURATION_JSON='{ \
       "PIPELINE": { \
              "CONFIGPATH": "/etc/opt/senzing", \
              "SUPPORTPATH": "/opt/senzing/data", \
              "RESOURCEPATH": "/opt/senzing/g2/resources" \
       }, \
       "SQL": { \
              "CONNECTION": "sqlite3://na:na@/var/opt/senzing/sqlite/G2C.db" \
       } \
    }' \
    SENZING_SKIP_DATABASE_PERFORMANCE_TEST=true
