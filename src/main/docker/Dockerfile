FROM openjdk:12.0.1-jdk-oraclelinux7

ARG installfile=file_not_set

ADD kafdrop.sh /
# automatically unpacks
ADD  $installfile /

RUN chmod +x /kafdrop.sh

ENTRYPOINT ["/kafdrop.sh"]
