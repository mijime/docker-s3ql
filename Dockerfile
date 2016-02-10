FROM phusion/baseimage

ENV \
      S3QL_URL=swift://server/container \
      S3QL_STORAGE=file/to/path \
      S3QL_LOGIN=username \
      S3QL_PASSWD=password \
      S3QL_FSPASSWD=FS_password \
      S3QL_COMPRESS=zlib \
      S3QL_MOUNT_POINT=/mnt \
      S3QL_MAX_OBJ_SIZE=10240 \
      S3QL_CACHESIZE= \
      S3QL_SUBNET=172.17.0.0/16 \
      S3QL_LOGFILE=/root/.s3ql/mount.log

# Dependencies
COPY build.sh /build.sh
RUN chmod 755 /build.sh
RUN /build.sh

#Adding Startup, shutdown
COPY s3ql /etc/service/s3ql
RUN chmod 0755 /etc/service/s3ql/*

EXPOSE 111/udp 2049/tcp

# Baseimage init process
ENTRYPOINT ["/sbin/my_init"]
VOLUME /root/.s3ql
