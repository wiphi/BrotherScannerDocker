FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean
RUN apt-get -y install sane sane-utils ghostscript netpbm x11-common- wget graphicsmagick curl libtiff-tools && apt-get -y clean

RUN cd /tmp && \
    wget https://download.brother.com/welcome/dlf105200/brscan4-0.4.10-1.amd64.deb && \
    dpkg -i /tmp/brscan4-0.4.10-1.amd64.deb && \
    rm /tmp/brscan4-0.4.10-1.amd64.deb

RUN cd /tmp && \
    wget https://download.brother.com/welcome/dlf006652/brscan-skey-0.3.1-2.amd64.deb && \
    dpkg -i /tmp/brscan-skey-0.3.1-2.amd64.deb && \
    rm /tmp/brscan-skey-0.3.1-2.amd64.deb

ADD files/runScanner.sh /opt/brother/runScanner.sh

ENV NAME=""
ENV MODEL=""
ENV IPADDRESS=""

#only set these variables, if inotify needs to be triggered (e.g., for CloudStation):
#ENV SSH_USER="admin"
#ENV SSH_PASSWORD="admin"
#ENV SSH_HOST="localhost"
#ENV SSH_PATH="/path/to/scans/folder/"

#only set these variables, if you need FTP upload:
#ENV FTP_USER="scanner"
#ENV FTP_PASSWORD="scanner"
#ENV FTP_HOST="ftp.mydomain.com"
#ENV FTP_PATH="/"

EXPOSE 54925
EXPOSE 54921

#directory for scans:
VOLUME /home/brotherscanner/brscan

#directory for config files:
VOLUME /opt/brother/scanner/brscan-skey

CMD /opt/brother/runScanner.sh
