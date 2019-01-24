FROM centos:7

RUN yum upgrade -y && yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum -y install iptables-services && systemctl enable iptables
RUN rm -f /etc/sysconfig/iptables && touch /etc/sysconfig/iptables && chmod 600 /etc/sysconfig/iptables;
RUN echo -en "*mangle"'\n'\
":PREROUTING ACCEPT [3:204]"'\n'\
":INPUT ACCEPT [3:204]"'\n'\
":FORWARD ACCEPT [0:0]"'\n'\
":OUTPUT ACCEPT [3:260]"'\n'\
":POSTROUTING ACCEPT [3:260]"'\n'\
"COMMIT"'\n'\
"*nat"'\n'\
":PREROUTING ACCEPT [0:0]"'\n'\
":POSTROUTING ACCEPT [0:0]"'\n'\
":OUTPUT ACCEPT [0:0]"'\n'\
"-A PREROUTING -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8080"'\n'\
"-A PREROUTING -p tcp -m tcp --dport 4949 -j REDIRECT --to-ports 9990"'\n'\
"-A PREROUTING -p tcp -m tcp --dport 4848 -j REDIRECT --to-ports 9993"'\n'\
"-A PREROUTING -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 8443"'\n'\
"COMMIT"'\n'\
"*filter"'\n'\
":INPUT ACCEPT [0:0]"'\n'\
":FORWARD ACCEPT [0:0]"'\n'\
":OUTPUT ACCEPT [0:0]"'\n'\
"-A INPUT -p tcp -m tcp --dport 9993 -j ACCEPT"'\n'\
"-A INPUT -p tcp -m tcp --dport 9990 -j ACCEPT"'\n'\
"-A INPUT -p tcp -m tcp --dport 8443 -j ACCEPT"'\n'\
"-A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT"'\n'\
"-A INPUT -p tcp -m tcp --dport 8009 -j ACCEPT"'\n'\
"-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT"'\n'\
"-A INPUT -p icmp -j ACCEPT"'\n'\
"-A INPUT -i lo -j ACCEPT"'\n'\
"-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT"'\n'\
"-A INPUT -j REJECT --reject-with icmp-host-prohibited"'\n'\
"-A FORWARD -j REJECT --reject-with icmp-host-prohibited"'\n'\
"COMMIT" >> /etc/sysconfig/iptables;
EXPOSE 80 8080 22 443 
