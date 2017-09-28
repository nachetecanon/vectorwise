FROM centos:7

MAINTAINER kevin@predictx.com <Kevin Thorpe>

ADD pi.repo /etc/yum.repos.d
ADD vector.sh /etc/profile.d

RUN yum -y install sudo jdk1.8.0_131.x86_64 actian-vector actian-vector-net actian-vector-dbms

# start vector for the first time which will initialise it
RUN /etc/init.d/actian-vectorVW start

ADD entrypoint.sh /

USER actian
CMD /entrypoint.sh


