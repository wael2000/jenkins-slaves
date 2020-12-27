FROM registry.redhat.io/openshift4/ose-jenkins-agent-base

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


RUN dnf install dotnet-sdk-3.1
#yum install dotnet-sdk-3.1 -y --setopt=tsflags=nodocs && \
#    yum clean all -y 

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
