FROM       centos:centos7
MAINTAINER Dane Lipscombe <dane@lipscombe.com.au> 2014.12.13

RUN yum -y install epel-release yum -y update && yum clean all

RUN yum -y install tar supervisor

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 -o /usr/bin/confd && chmod u+x /usr/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}

ADD files/boot.sh /usr/bin/boot.sh
RUN chmod u+x /usr/bin/boot.sh

RUN mv /etc/supervisord.conf ~
ADD files/supervisord.conf /etc/supervisord.conf

ADD files/confd.conf /etc/supervisord.d/confd.conf

CMD ["/usr/bin/boot.sh"]
