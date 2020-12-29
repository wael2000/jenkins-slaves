# jenkins-slaves

# sonarqube-template

oc process -f https://raw.githubusercontent.com/siamaksade/sonarqube/8/sonarqube-template.yaml | oc create -f -

oc process -f https://raw.githubusercontent.com/siamaksade/sonarqube/8/sonarqube-persistent-template.yaml | oc create -f -
