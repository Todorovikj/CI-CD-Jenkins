pipeline {
  agent any
  stages {
        stage('Test') {
  options {
                timeout(time: 5, unit: "MINUTES")
            }

      steps {
          sh "sudo docker run --rm -u gradle -v ${env.WORKSPACE}/Backend_gradle:/home/gradle/project -w /home/gradle/project gradle gradle test"
      }
    }


      stage('Deploy'){

      options {
                timeout(time: 10, unit: "MINUTES")
      } 

      when {
        branch 'develop'
      }

      steps{
        // ADD my existing ssh key
        // sh 'eval "$(ssh-agent -s)"'
        // sh 'ssh-add ~/.ssh/id_rsa'

        // get backend ready for deploy
         sh "sudo docker run --rm -u gradle -v ${env.WORKSPACE}/Backend_gradle:/home/gradle/project -w /home/gradle/project gradle gradle clean build"

        // get angular ready for deploy
         sh "sudo docker run --rm -v ${env.WORKSPACE}/Angular:/usr/src/app todorovikj/install_angular_modules"
         sh "sudo docker run --rm -v ${env.WORKSPACE}/Angular:/usr/src/app todorovikj/build_angular_img"

        // RUN ANSIBLE  dev script

          dir(path: './playbooks') {
            sh "ansible-playbook dev-playbook.yml"
          }

        // clean backend files after deploy
          dir(path: './Backend_gradle') {
           sh "sudo rm -r build"
          }

        // clean angular files after deploy
          dir(path: './Angular') {
           sh "sudo rm -r node_modules"
           sh "sudo rm -r dist"
          }
      }
    }

  }
}