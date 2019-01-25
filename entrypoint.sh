#!/bin/bash
# create directory fot FTP data
export FTP_STORAGE_DIR="/var/FTP"
# create user
useradd -m -p $(openssl passwd -1 ${FTP_PASS}) -s /bin/bash -d ${FTP_STORAGE_DIR} ${FTP_USER}
#
echo "test file" > ${FTP_STORAGE_DIR}/test.txt
chown -R ${FTP_USER}:${FTP_USER} ${FTP_STORAGE_DIR}
# modify configuration
sed -i 's/listen.*/#listen.*/' /etc/vsftpd.conf
echo "#auto-generated configuration" >> /etc/vsftpd.conf
echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd.conf
echo "pasv_max_port=${PASV_MAX_PORT}" >> /etc/vsftpd.conf
echo "pasv_min_port=${PASV_MIN_PORT}" >> /etc/vsftpd.conf
echo "pasv_addr_resolve=${PASV_ADDR_RESOLVE}" >> /etc/vsftpd.conf
echo "write_enable=YES" >> /etc/vsftpd.conf
echo "log_ftp_protocol=YES" >> /etc/vsftpd.conf
echo "ftpd_banner=NETWORK FTP service. Welcome" >> /etc/vsftpd.conf
echo "secure_chroot_dir=/var/vsftpd" >> /etc/vsftpd.conf
echo "listen=YES" >> /etc/vsftpd.conf
echo "listen_port=21" >> /etc/vsftpd.conf

# start service
/usr/sbin/vsftpd
