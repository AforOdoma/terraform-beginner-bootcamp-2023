# Terraform Beginner Bootcamp 2023

## Semantic Versioning: image:

This Project is going to utilize semantic versioning for its tagging.
[server.org](https://semver.org/)

The general format:
**MAJOR.MINOR.PATCH**, eg. `1.0.1`

* **MAJOR** version when you make incompatible API changes
* **MINOR** version when you add functionality in a backward compatible manner
* **PATCH** version when you make backward compatible bug fixes

## Install the Terraform Cli

### Considerations with the Terraform CLI changes 

The Terraform CLI installation instructions have changed due to keyring changes. So we needed to refer to the latest install CLI instructions via Terrform Documentation and change the scripting for install. 

- [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Considerations for Linux Distribution

This project is built against Ubuntu. 
Please consider checking your linux distribution and change accourdingly to distribution needs.   

[How To Cheak OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues, we noticed the bash script steps were a considerable amout more code. So we decided to create a bash script to install the terraform cli.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will alow us an easier time to deburg and execute manually Terraform CLI install
- This will alow better portability for other projects that need to install Terraform CLI

#### Shebang Considerations
A Sheband (pronounced Sha_bang) tells the bash script the program that will interprete the bash script. Eg. `#!/usr/bin/env bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- For potability for different OS distributions
- Will search the user's PATH for the bash executable. 

- [Shebang (Unix)](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations 
When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interprete it.   

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permissions for the file to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

[chmod](https://en.wikipedia.org/wiki/Chmod)

### Github Lifecycle (Before, init, command)

We need to be carefull when using the init because it will not rerun if we restart an existing workspace. 

[Gitpod](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Env Vars

We can list oput all Environmental Variables (Env Vars) using the 'env' command.

We can filter specific env var using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='WORLD'`

In the terminal we unset using `unset Hello`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script wee can set up an env var without writing export eg

```sh
#!/usr/bin/env bash

HELLO-'world'

echo $ HELLO
```

#### Printing Env Var

We can print an Env Var using eco eg. `echo Hello`

#### Scoping of Env Vars

When you open up a new bah trerminal in VSCode it will not be aware of Env Vars that you have set in another window. 
If you want Env Vars to persist accross all future basah terminals that are open you need to set env vars in your bash profile. Eg.  `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env Vars in Gitpod by storing them in Gitpod Secrets Storage.

```
gp env Hello=`world`

```

All future workspaces launched will set the env vars for all bash terminals opened in those workspace. 

You can also set the en vars in the `.gitpod.yml` but this can only contain non-sensitive env vars. 

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting started install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity 
```

if it is successfull you should see a json payload return that looks like this:

```json
{
    "UserId": "AKIAIOSFODNNMYEXAMPLETODAY",
    "Account": "879787978797",
    "Arn": "arn:aws:iam::879787978797:user/terraform-beginner-bootcamp"
}

```

We'll need to generate AWS CLI credentials from IAM user in order to use the AWS CLI. 

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from terrraform registry which is located at [registry.terraform.io](https://registry.terraform.io/) 

- **Providers** is an interface to API's that will allow you to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable, and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform provider that will use in this project.  

#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputing. 

#### Terraform Apply

`Terraform Apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes and no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

### Terraform lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project. 

The Terraform lock file **should be committed** to  your Version Control System (VCS) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure. 

This file **should not be committed** -to your Version Control System (VCS).

This file can contain sensitive data.

If you loose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of 
terraform providers.

### Writing a module with Terraforms

**Steps**
**Step 1**
- Go to your   browser and type 'Terraform Registery'
- [Terraform registry](https://registry.terraform.io/) is opened. In the search bar type 'random'. Then select 'Use provider'
- Copy the code 

```
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}
```
- Go to the VS Code environment and open the file 'main.tf'
- Paste the code in 'main.tf'. 
- Go back to the [Terraform registry](https://registry.terraform.io/) 
- On the random documentation page, under 'random provider' click on 'resources' and select 'random_string'.
- Scroll down to 'Example usage' and copy the code 
```
resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}
```

- Scroll down to the end of the code and add the copied resource. 

- Go to your browser and type 'Outputs terraform'
- Select [Output Values - Configuration Language | Terraform](https://developer.hashicorp.com/terraform/language/values/outputs)
- [Output Values](https://developer.hashicorp.com/terraform/language/values/outputs) is opened. Scroll down to [Declaring an Output Value](https://developer.hashicorp.com/terraform/language/values/outputs#declaring-an-output-value)
- Copy the code 

```
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```
- Go to the VS Code environment and add it to the end of the code in 'main.tf'

- Edit the code to the form below

```
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 16
  special          = false 
}

output "random_bucket_name_id" {
  value = random_string.bucket_name.id
}

output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}
```

- They are two tabs. 
- Select the terraform tab. 
- Run 
```
terraform
```

- Run 
```
terraform init
```
- Run 
```
terraform plan
```
- Run 
```
terraform apply
```
- It will request you to "Enter a value"
type in 'yes'

- Change the code in 'main.tf' **from**
```
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 16
  special          = false 
}

output "random_bucket_name_id" {
  value = random_string.bucket_name.id
}

output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}
```
**to** 

```
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 16
  special          = false 
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}
```
- Run 
```
terraform plan
```
- Run
```
terraform apply --auto-approve
```
- To see available commands for execution in terraform, run
```
terraform
```
- To display output values from your root module run 
```
terraform output
```
- To display the name, run 
```
terraform output random_bucket_name
```

## Reference

- [Semantic Versioning 2.0.0](https://semver.org/)
- [oh-my-bash](https://github.com/ohmybash/oh-my-bash)
- [What version of Linux am I running?](https://opensource.com/article/18/6/linux-version)



