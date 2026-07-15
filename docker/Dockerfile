FROM scratch

ARG GROUPID=1000
ARG USERID=1000
ARG USERNAME=jenkins
ARG GROUPNAME=jenkins

#ADD ubuntu-xenial-core-cloudimg-amd64-root.tar.gz /
ADD ubuntu-focal-core-cloudimg-amd64-root.tar.gz /
# delete all the apt list files since they're big and get stale quickly
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/systemd && echo 'docker' > /run/systemd/container

RUN apt-get update
RUN apt-get update --fix-missing

RUN apt-get -y install apt-utils

RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN apt-get -y install subversion g++ zlib1g-dev build-essential git python python3 python3-distutils libncurses5-dev gawk gettext unzip file libssl-dev wget libelf-dev ecj fastjar java-propose-classpath gcc-multilib clang flex bison g++-multilib libncurses-dev python3-setuptools swig python3-pip device-tree-compiler

RUN apt-get -y install lua5.1 zip rsync curl libcap-dev

RUN pip3 install PyCryptodome

# Builder user
RUN addgroup $USERNAME --gid $GROUPID
RUN adduser $USERNAME --uid $USERID --gid $GROUPID --disabled-password --gecos "" --home /home/$USERNAME; \
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN chown $USERNAME:$GROUPNAME -R /home/$USERNAME

USER $USERNAME

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]
