# IDgis/sshd

A small docker image containing a ssh deamon. Can be used to (temporarily) access docker containers by means of an ssh tunnel.

## How to use:
- start container: docker run -e PASSWORD=secret -P --name my_sshd [--link container_name] [--net network_name] -d idgis/sshd
- determine mapped ssh port: docker port my_sshd
- create tunnel: ssh -L localport:hostname:port root@hostname:port
- stop container: docker stop my_sshd && docker rm my_sshd

## Example 1:
In this scenario there is a container named 'my_db' running on a docker host and we would like to be able to connect to a service running
on port 5432.

- docker run -e PASSWORD=secret -P --name my_sshd **--link my_db** -d idgis/sshd
- docker port my_sshd (example output: 22/tcp -> 0.0.0.0:32773)

from client:

- ssh -L 5555:my_db:5432 root@host:32773

It is now possible to access the remote database by connecting to localhost:5555.

## Example 2:
It is also possible to attach to a docker network. Let's assume that the container from the previous example is attached to a 
network named 'my_network' (list networks with 'docker network ls').

- docker run -e PASSWORD=secret -P --name my_sshd **--net my_network** -d idgis/sshd
- docker port my_sshd (example output: 22/tcp -> 0.0.0.0:32773)

from client:

- ssh -L 5555:my_db:5432 root@host:32773 (where my_db is the name of the db container)

It is now again possible to access the remote database by connecting to localhost:5555.
N.B. Make sure port 32773 is open in the firewall.
