ARG PATCH_NAME=patch13209
ARG ACTIAN_NAME=actian-vector-6.0.0-132-com-linux-rpm-x86_64-13204
FROM alpine:3.12.2 as downloader
ARG PATCH_NAME
ARG ACTIAN_NAME

ENV PATCH_URL=http://repository/resources/actian-vector-6.0.0-132-linux-x86_64-p13209.tar.Z \
    ACTIAN_URL=http://repository/resources/actian-vector-6.0.0-132-com-linux-rpm-x86_64-13204.tgz

RUN apk add  --update-cache curl  tar unzip  bash && \
    curl $PATCH_URL -o /tmp/patch.Z && \
    curl $ACTIAN_URL -o /tmp/actian.tgz && \
    mkdir -p /opt/actian && \
    tar xfz  /tmp/actian.tgz -C /opt/actian && \
    tar xfz /tmp/patch.Z -C /opt/actian
#========================================================================================================
# service command must be provided, and systemd should be enabled
# this suggestion about enabling systemd comes from https://github.com/CentOS/sig-cloud-instance-images/issues/28
#========================================================================================================
FROM scratch
ADD centos-7-docker.tar.xz /
ARG PATCH_NAME
ARG ACTIAN_NAME

MAINTAINER nacho.canon@predictx.com <Nacho Canon>

ENV II_SYSTEM=/opt/Actian/VectorVW\
    II_INSTALLATION=VW \
    PATH=$PATH:$II_SYSTEM/ingres/bin:$II_SYSTEM/ingres/utility \
    AWK_CMD=/usr/bin/awk \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$II_SYSTEM/ingres/lib

COPY --from=downloader /opt/actian/${ACTIAN_NAME} /opt/actian
COPY --from=downloader /opt/actian/${PATCH_URL}   /opt/actian
ADD entrypoint.sh /
#ADD pi.repo /etc/yum.repos.d
#ADD vector.sh /etc/profile.d
# this install all dependencies before running VW installation.
# After installation, a patch is applied to that.
# Instructions following the patch.html file contained in patch distribution
RUN yum -y install sudo libaio java-11-openjdk initscripts gawk && \
    yes | /opt/actian/${ACTIAN_NAME}/install.sh  -express -acceptlicense && \
    chmod +x /entrypoint.sh

USER actian

CMD ["/entrypoint.sh"]

