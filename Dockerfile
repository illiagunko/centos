FROM centos:7

RUN yum upgrade -y && yum -y install httpd; yum clean all; systemctl enable httpd.service

EXPOSE 80 8080 22 443 
