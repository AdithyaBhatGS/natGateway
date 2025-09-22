# NAT Gateway Project

A simple project to setup the NAT Gateway using terraform.

We use SSM Endpoints to login to the Private Instance and try to access the internet through the NAT Gateway

Using SSM Endpoints reduces the port exposure

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
7. Create 3 SSM Endpoints
   - ssm
   - ec2messages
   - ssmmessages
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
    - [ssm_endpoints/](./modules/ssm_endpoints/)
      - [main.tf](./modules/ssm_endpoints/main.tf)
      - [outputs.tf](./modules/ssm_endpoints/outputs.tf)
      - [README.md](./modules/ssm_endpoints/README.md)
      - [variables.tf](./modules/ssm_endpoints/variables.tf)
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
