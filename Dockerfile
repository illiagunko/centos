FROM centos:7

RUN yum upgrade -y && yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum -y install iptables-services && sudo systemctl enable iptables.service && service iptables start && systemctl stop firewalld && systemctl mask firewalld && service iptables save

EXPOSE 80 8080 22 443 
