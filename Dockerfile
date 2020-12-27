FROM registry.redhat.io/openshift3/jenkins-slave-base-rhel7

USER root

ENV HOME=/home/jenkins 

# Install headless Java and .NET sdk
RUN yum install dotnet-sdk-3.1 -y && \
    yum clean all

WORKDIR /

# Install SonarQube Scanner as the running user
RUN dotnet tool install --global dotnet-sonarscanner
ENV PATH="${PATH}:$HOME/.dotnet/tools"

RUN chown -R 1029:0 /usr/local/bin && \
    chown -R 1029:0 $HOME && \
    chmod -R g+rwx $HOME

USER 1029
