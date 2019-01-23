FROM centos:7

RUN yum upgrade -y && yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum -y install iptables-services && systemctl enable iptables
RUN iptables-save && service iptables restart
ADD iptables /etc/sysconfig/
EXPOSE 80 8080 22 443 
