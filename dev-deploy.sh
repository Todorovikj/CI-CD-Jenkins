#!/bin/bash


cd ./Angular

#building the front-end
ng build --prod

cd ..


# build the backend of the application
cd ./Backend_gradle

./gradlew clean build

cd ..

#Execute the dev-playbook with ansible. 

cd ./playbooks

ansible-playbook dev-playbook.yml