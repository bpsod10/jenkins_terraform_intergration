pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            metadata:
                labels:
                    app: test
            spec:
                containers:
                - name: terraform
                  image: hashicorp/terraform
                  command:
                  - cat
                  tty: true
                - name: git
                  image: bitnami/git:latest
                  command:
                  - cat
                  tty: true
            '''
        }      
    }
    options {
        timeout(time: 10, unit: 'MINUTES') 
        buildDiscarder(logRotator(numToKeepStr: '2')) 
    }
    parameters { 
        choice(name: 'WORKFLOW', choices: ['apply', 'destroy'], description: 'Select terraform workflow') 
    }
    stages {
        stage('checkout scm') {
            steps {
                container('git') {
                   git credentialsId: 'github_creds', url: 'https://github.com/bpsod10/jenkins_terraform_intergration.git'
                }
            }
        }
        stage('terraform init') {
            steps {
                container('terraform') {
                    withCredentials([usernamePassword(credentialsId: 'aws', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                        sh 'terraform init'
                    }
                }
            }
        }    
        stage('terraform apply or destroy') {
            steps {
                container('terraform') {
                    withCredentials([usernamePassword(credentialsId: 'aws', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                        sh 'terraform ${WORKFLOW} -auto-approve'
                    }
                }
            }
        }
    }
}
