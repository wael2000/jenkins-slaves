# jenkins-slaves

# sonarqube-template

oc process -f https://raw.githubusercontent.com/wael2000/jenkins-slaves/master/sonarqube-template.yaml | oc create -f -

oc process -f https://raw.githubusercontent.com/wael2000/jenkins-slaves/master/sonarqube-persistent-template.yaml | oc create -f -
