FROM centos:centos8
MAINTAINER Chris Saunders <hello@saundersdigital.com.au>

## Install repo epel
RUN yum install -y epel-release

## Install dependencies
RUN yum install -y clamav clamav-update clamav-db wget tar which perl

## Install maldet, update antivirus signatures for maldet and clamav
RUN cd /tmp/ && \
    wget http://www.rfxn.com/downloads/maldetect-current.tar.gz && \
    tar -xzf maldetect-current.tar.gz && \
    cd(){ builtin cd "${@:1:1}"; } && \
    cd maldetect-* && \
    sh ./install.sh && \
    maldet --update && \
    freshclam

## Fix for work -h parameter
RUN sed -i 's/more/less/' /usr/local/sbin/maldet

### Volumes
VOLUME ["/htdocs"]

### Main
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["maldet"]
