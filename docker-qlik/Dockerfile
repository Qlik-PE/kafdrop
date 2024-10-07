FROM rockylinux:9

ARG installfile=file_not_set

RUN dnf install -y java-17-openjdk java-17-openjdk-devel


ADD kafdrop.sh /
# automatically unpacks
ADD  $installfile /

RUN chmod +x /kafdrop.sh

ENTRYPOINT ["/kafdrop.sh"]
