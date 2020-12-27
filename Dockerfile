FROM registry.redhat.io/openshift4/ose-jenkins-agent-base

#FROM openshift3/jenkins-slave-base-rhel7:v3.11.318-2

# Labels consumed by Red Hat build service
LABEL com.redhat.component="rh-dotnet31-jenkins-slave-container" \
      name="dotnet/dotnet-31-jenkins-slave-rhel7" \
      version="3.1" \
      architecture="x86_64" \
      release="42" \
      io.k8s.display-name="Jenkins Slave .NET Core 3.1" \
      io.k8s.description="The jenkins slave dotnet image has the dotnet tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,dotnet,dotnet21"

# Don't download/extract docs for nuget packages
# Don't do initially populate of package cache
# Enable nodejs and dotnet scl
ENV DOTNET_CORE_VERSION=3.1 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    ENABLED_COLLECTIONS="rh-nodejs10 rh-dotnet31" \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

COPY contrib/bin/scl_enable /usr/local/bin/scl_enable

# Install
RUN INSTALL_PKGS="rh-dotnet31 rh-nodejs10-npm" && \
    yum install -y --setopt=tsflags=nodocs --disablerepo=\* \
      --enablerepo=rhel-7-server-rpms,rhel-server-rhscl-7-rpms,rhel-7-server-dotnet-rpms \
      $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
# yum cache files may still exist (and quite large in size)
    rm -rf /var/cache/yum/*

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
