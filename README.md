# NAT Gateway Project

A simple project to setup the NAT Gateway using terraform.

We use SSM to login to the Private Instance and try to access the internet through the NAT Gateway

## Steps to achieve this:

1. Create a VPC
2. Create 2 Subnets
   - Public Subnet( for NAT Gateway)
   - Private Subnet( for EC2 Instance)
3. Create an Internet Gateway
4. Create a NAT Gateway
5. Create 2 Route Tables
   - One for the public subnet
   - Another for the private subnet
6. Create the security groups
   - One for EC2 instance
   - Another for the SSM Endpoints
8. Create an IAM Role, attach the trust entity to establish the trust relationship, add the managed policy named **_AmazonSSMManagedInstanceCore_**, create an instance profile
9. Finally create the EC2 module for testing the working of the NAT Gateway

## Project Organization

This project is organized into two main folders:

- **modules/** → contains all the modules.
- **test/** → modules are called and tested in this folder.

## Project Structure

- [natGateway/](./)

  - [modules/](./modules/)

    - [ec2/](./modules/ec2/)
      - [main.tf](./modules/ec2/main.tf)
      - [outputs.tf](./modules/ec2/outputs.tf)
      - [README.md](./modules/ec2/README.md)
      - [variables.tf](./modules/ec2/variables.tf)
    - [iam/](./modules/iam/)
      - [main.tf](./modules/iam/main.tf)
      - [outputs.tf](./modules/iam/outputs.tf)
      - [README.md](./modules/iam/README.md)
      - [variables.tf](./modules/iam/variables.tf)
    - [igw/](./modules/igw/)
      - [main.tf](./modules/igw/main.tf)
      - [outputs.tf](./modules/igw/output.tf)
      - [README.md](./modules/igw/README.md)
      - [variables.tf](./modules/igw/variables.tf)
    - [nat_gateway/](./modules/nat_gateway/)
      - [main.tf](./modules/nat_gateway/main.tf)
      - [outputs.tf](./modules/nat_gateway/outputs.tf)
      - [README.md](./modules/nat_gateway/README.md)
      - [variables.tf](./modules/nat_gateway/variables.tf)
    - [rt/](./modules/rt/)
      - [main.tf](./modules/rt/main.tf)
      - [outputs.tf](./modules/rt/outputs.tf)
      - [README.md](./modules/rt/README.md)
      - [variables.tf](./modules/rt/variables.tf)
    - [security_groups/](./modules/security_groups/)
      - [main.tf](./modules/security_groups/main.tf)
      - [outputs.tf](./modules/security_groups/outputs.tf)
      - [README.md](./modules/security_groups/README.md)
      - [variables.tf](./modules/security_groups/variables.tf)
    - [subnet/](./modules/subnet/)
      - [main.tf](./modules/subnet/main.tf)
      - [outputs.tf](./modules/subnet/outputs.tf)
      - [README.md](./modules/subnet/README.md)
      - [variables.tf](./modules/subnet/variables.tf)
    - [vpc/](./modules/vpc/)
      - [main.tf](./modules/vpc/main.tf)
      - [outputs.tf](./modules/vpc/outputs.tf)
      - [README.md](./modules/vpc/README.md)
      - [variables.tf](./modules/vpc/variables.tf)

  - [test/](./test/)

    - [.terraform.lock.hcl](./test/.terraform.lock.hcl)
    - [main.tf](./test/main.tf)
    - [outputs.tf](./test/outputs.tf)
    - [variables.tf](./test/variables.tf)
    - [README.md](./test/README.md)

  - [.gitignore](./.gitignore)

  - [README.md](./README.md)

## How to Run

1. Clone the repository.
2. Navigate to the `test/` folder.
3. Run the project, for example:

   ```bash
   terraform plan
   ```

   ```bash
   terraform apply
   ```

## How to test the working of NAT Gateway:

1. Login to the AWS Management Console
2. Login to the EC2 instance using the SSM Access
   - Since we are using the SSM we do not need keys for login
3. Once logged into the instance:

   - Test the internet access:

     - ```
       ping -c 4 google.com
       ```

   - Update the package manager:

     - ```
       sudo apt-get update
       ```

   - Check Public IP:

     - ```
       curl http://checkip.amazonaws.com
       ```
     - curl - used for making web requests

     - http://checkip.amazonaws.com - A web service by aws that sends back the public IP of your instance

     - The public IP must match with that of the Elastic IP that you have attached to your NAT Gateway

## Using Jenkins for automating the workload:

All the code required to setup the jenkins have been mentioned below:

Check out my other repo: [jenkins-setup](https://github.com/AdithyaBhatGS/jenkins-setup)

### Steps(to automate the deployment of the NAT Gateway):

1. Go to the above repo
2. Clone the repo
3. Setup the instance which contains Jenkins
4. Login using SSM console
5. Run this:
   - ```bash
      cat /var/jenkins_home/secrets/initialAdminPassword
     ```
   - Copy the password from the console
   - Paste it to the Jenkins UI
   - Install the recommended plugins
   - Provide the details including username, password etc.
6. Now go to manage
   - Go to plugins
   - Install the plugin **_AWS_CREDENTIALS_**
7. Now in the manage
   1. Go to credentials
   2. Go to global
   3. Click on add credentials
   4. Choose the type as secrets file
   5. Upload the terraform.tfvars file
   6. Mention the **_ID_** as **_TFVARS_FILE_**
   7. Click on save
   8. Go to credentials
   9. Click on add credentials
   10. Choose the type as **_AWS Credentials_**
   11. Add your
       - **_Access key_**
       - **_Secrets key_**
   12. Go to Jenkins home page
   13. Click on create job
   14. Choose the **_pipeline job_**
   15. Mention the description
   16. Choose the polling as:
      - Go for **_GitHub Webhook for GitHub SCM polling_**
   17. Mention the above repo as Source Code for your Jenkinsfile
   18. Change the brach as **_main_** from **_master_**
   19. Click on **_Save_**
8. Add the WebHook
   - Go to your GitHub account
   - Go to WebHooks
   - Click add WebHook
   - Under Payload URL
     - http://<ec2-ip>:8080/github-webhook
   - Chnage the content type to application/json
   - Under the events choose **_Just the push event_**
9. Trigger the event
   - Go to your forked repo
   - Change some code
   - Check jenkins for trigger     
