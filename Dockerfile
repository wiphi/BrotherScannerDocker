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

# Main run-file
ADD files/runScanner.sh /opt/brother/runScanner.sh

# default script files
ADD script/scantoemail.sh /tmp/script/scantoemail.sh
ADD script/scantofile.sh /tmp/script/scantofile.sh
ADD script/scantoimage.sh /tmp/script/scantoimage.sh
ADD script/scantoocr.sh /tmp/script/scantoocr.sh

# environment
ENV NAME=""
ENV MODEL=""
ENV IPADDRESS=""

# ports
EXPOSE 54925
EXPOSE 54921

#volumes
#directory for scans:
VOLUME /home/brotherscanner/brscan

#directory for config files:
VOLUME /opt/brother/scanner/brscan-skey

# entry command
CMD /opt/brother/runScanner.sh
