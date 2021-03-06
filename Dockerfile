FROM ubuntu:xenial

RUN apt-get update && \
	apt-get install -y openssh-server && \
	mkdir /var/run/sshd && \
	sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	rm -rf /etc/ssh/ssh_host_*
	
COPY start.sh /

RUN chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]