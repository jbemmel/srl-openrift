ARG SR_LINUX_RELEASE
FROM ghcr.io/nokia/srlinux:$SR_LINUX_RELEASE

ARG P1="/usr/local/lib/python3.6/site-packages:/usr/local/lib64/python3.6/site-packages"
ARG P2="/opt/rh/rh-python36/root/usr/lib/python3.6/site-packages/sdk_protos"
ARG P3="/usr/lib/python3.6/site-packages/sdk_protos"
ENV AGENT_PYTHONPATH="$P1:$P2:$P3"

# Install pyGNMI to /usr/local/lib[64]/python3.6/site-packages
# RUN sudo yum-config-manager --disable ipdcentos ipdrepo ius && sudo yum clean all
RUN sudo yum install -y python3-pip gcc-c++ pylint git
    # && \
    # sudo python3 -m pip install pip --upgrade && \
    # sudo python3 -m pip install pygnmi pylint-protobuf

# Build open source RIFT, see https://github.com/brunorijsman/rift-python/blob/master/doc/installation.md
# Fork of https://github.com/brunorijsman/rift-python.git
RUN sudo git clone https://github.com/jbemmel/rift-python.git /opt/rift-python/ && \
    cd /opt/rift-python && sudo pip3 install -r requirements-3-567.txt

# Define custom aliases for admin user
RUN sudo mkdir -p /home/admin && printf '%s\n' \
  '[alias]' \
  '"containerlab save" = "save file /etc/opt/srlinux/config.json /"' \
  \
> /home/admin/.srlinuxrc

# Add global authorized_keys file
RUN sudo sed -i.orig 's|.ssh/authorized_keys|.ssh/authorized_keys /etc/ssh/authorized_keys|g' /etc/ssh/sshd_config
# This file must be owned by root:root with 644 permissions
COPY --chmod=0644 ./authorized_keys /etc/ssh/authorized_keys

COPY ./srl-*.yaml /opt/rift-python/topology/

# Using a build arg to set the release tag, set a default for running docker build manually
ARG SRL_OPENRIFT_RELEASE="[custom build]"
ENV SRL_OPENRIFT_RELEASE=$SRL_RIFT_RELEASE
