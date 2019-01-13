FROM centos:7

RUN yum upgrade -y && yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum -y install iptables-services && systemctl enable iptables
COPY iptables /etc/sysconfig/
EXPOSE 80 8080 22 443 
