# Project Name

This project is organized into two main folders:

- **modules/** → contains all the modules.
- **test/** → modules are called and tested in this folder.

# Project Structure

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
    - ssm_endpoints/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - subnet/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - vpc/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf

  - test/

    - .terraform.lock.hcl
    - main.tf
    - outputs.tf
    - variables.tf
    - README.md

  - .gitignore

  - README.md

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
