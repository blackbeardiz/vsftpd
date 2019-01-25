FROM ubuntu:latest
#
ARG USER=ciscoftp
ARG USER_ENCR_PASS=ciscoftp
#
RUN apt-get update && apt-get install -y vsftpd db-util nano openssl \
 && apt-get clean all
#
ENV PASV_ADDRESS 10.1.32.130
ENV PASV_ADDR_RESOLVE NO
ENV PASV_ENABLE YES
ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV FTP_USER ${USER}
ENV FTP_PASS ${USER_ENCR_PASS}
#
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
#
RUN mkdir -p /var/vsftpd
#
CMD ["/entrypoint.sh"]
