FROM centos:7

MAINTAINER kevin@predictx.com <Kevin Thorpe>

ADD pi.repo /etc/yum.repos.d
ADD vector.sh /etc/profile.d

RUN yum -y install sudo jdk1.8.0_131.x86_64 libaio actian-vector actian-vector-net actian-vector-dbms

ADD entrypoint-pre.sh /
ADD entrypoint.sh /

CMD /entrypoint-pre.sh


