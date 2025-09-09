# Project Name

This project is organized into two main folders:

- **modules/** → contains all the modules.
- **test/** → modules are called and tested in this folder.

# Project Structure

- natGateway/

  - modules/

    - ec2/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - iam/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - igw/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - nat_gateway/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - rt/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
    - security_groups/
      - main.tf
      - outputs.tf
      - README.md
      - variables.tf
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
