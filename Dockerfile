#FROM registry.redhat.io/openshift4/ose-jenkins-agent-base

FROM  openshift/ose-jenkins-agent-base:v4.5.0.20201212.044447

#FROM openshift3/jenkins-slave-base-rhel7:v3.11.318-2

# Labels consumed by Red Hat build service
LABEL com.redhat.component="rh-dotnet31-jenkins-slave-container" \
      name="dotnet/dotnet-31-jenkins-slave-rhel" \
      version="3.1" \
      architecture="x86_64" \
      release="42" \
      io.k8s.display-name="Jenkins Slave .NET Core 3.1" \
      io.k8s.description="The jenkins slave dotnet image has the dotnet tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,dotnet,dotnet31"

ENV NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    DOTNET_CORE_VERSION=3.1 
    #BASH_ENV=/usr/local/bin/scl_enable \
    #ENV=/usr/local/bin/scl_enable \
    #PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    #LANG=en_US.UTF-8 \
    #LC_ALL=en_US.UTF-8

#COPY contrib/bin/scl_enable /usr/local/bin/scl_enable
#COPY contrib/bin/configure-agent /usr/local/bin/configure-agent

RUN INSTALL_PKGS="aspnetcore-runtime-3.1 nss_wrapper tar unzip" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
# yum cache files may still exist (and quite large in size)
    rm -rf /var/cache/yum/*

#RUN yum repolist
#RUN yum update --disableplugin=subscription-manager -y && rm -rf /var/cache/yum
#RUN yum install --disableplugin=subscription-manager dotnet-sdk-3.1 -y && rm -rf

#RUN yum install -y dotnet-sdk-3.1 --setopt=tsflags=nodocs --disableplugin=subscription-manager 
# RUN dnf install dotnet-sdk-3.1 --setopt=tsflags=nodocs --disableplugin=subscription-manager
#yum install dotnet-sdk-3.1 -y --setopt=tsflags=nodocs && \
#    yum clean all -y 

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
