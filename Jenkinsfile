pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
        stage('Select Action') {
            steps {
                script {
                    // Interactive choice for initial action
                    env.ACTION = input(
                        message: 'Select Terraform Action:',
                        parameters: [
                            choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Choose Terraform action')
                        ]
                    )
                }
            }
        }

        stage('Setup & Validate') {
            steps {
                script {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CREDENTIALS'],
                        file(credentialsId: 'TFVARS_FILE', variable: 'TFVARS_PATH')
                    ]) {
                        dir('test') {
                            sh '''
                                echo "=== Terraform Init, Fmt, Validate ==="
                                terraform init -input=false
                                terraform fmt -check
                                terraform validate
                            '''
                        }
                    }
                }
            }
        }

        stage('Terraform Plan / Apply / Destroy') {
            steps {
                script {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CREDENTIALS'],
                        file(credentialsId: 'TFVARS_FILE', variable: 'TFVARS_PATH')
                    ]) {
                        dir('test') {
                            if (env.ACTION == 'plan') {
                                // Run plan and ask if user wants to apply
                                sh 'terraform plan -out=tfplan -var-file=$TFVARS_PATH'
                                def applyConfirm = input(message: "Do you want to apply this plan?", ok: "Apply")
                                sh 'terraform apply -auto-approve tfplan'

                                // After apply, ask if user wants to destroy
                                def destroyConfirm = input(message: "Do you want to destroy the infrastructure now?", ok: "Destroy")
                                if (destroyConfirm) {
                                    sh 'terraform destroy -auto-approve -var-file=$TFVARS_PATH'
                                }

                            } else if (env.ACTION == 'apply') {
                                input(message: "Confirm apply?", ok: "Apply")
                                sh 'terraform apply -auto-approve -var-file=$TFVARS_PATH'

                                // Prompt optional destroy after apply
                                def destroyConfirm = input(message: "Do you want to destroy the infrastructure now?", ok: "Destroy")
                                if (destroyConfirm) {
                                    sh 'terraform destroy -auto-approve -var-file=$TFVARS_PATH'
                                }

                            } else if (env.ACTION == 'destroy') {
                                input(message: "Are you sure you want to destroy the infrastructure?", ok: "Destroy")
                                sh 'terraform destroy -auto-approve -var-file=$TFVARS_PATH'
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo "✅ Terraform ${env.ACTION} stage completed."
        }
    }
}
