FROM phusion/baseimage

RUN curl -LO https://bintray.com/artifact/download/erlio/vernemq/deb/trusty/vernemq_0.12.5p4-1_amd64.deb && \
    dpkg -i vernemq_0.12.5p4-1_amd64.deb && \
    rm -rf vernemq_0.12.5p4-1_amd64.deb

ADD vernemq.conf /etc/vernemq/vernemq.conf
ADD vmq.passwd /etc/vernemq/vmq.passwd
ADD myinit_vernemq.sh /etc/my_init.d/myinit_vernemq.sh


