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

#### Terraform Destroy

`teraform destroy`
This will destroy resources. 

You can also use the auto approve flag to skip the approve prompt. eg. `terraform apply --auto-approve`

#### Terraform lock files 

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

## Issues with Creating an S3 bucket
I kept getting errors while trying to create an S3 bucket so I edited my bucket name to use a dash instead of an underscore. I used an article on [Troubleshooting: Error After Creating S3 Bucket with Terraform](https://saturncloud.io/blog/troubleshooting-error-after-creating-s3-bucket-with-terraform). Scrolled to 
[Step 1: Verify the S3 Bucket Name](https://saturncloud.io/blog/troubleshooting-error-after-creating-s3-bucket-with-terraform/#step-1-verify-the-s3-bucket-name) to compare with a version of a correct code.

## Issues with Terraform Cloud Login and Gitpod workspace

I was able to successfully run the entire project twice. My laptop froze when I was almost done. I had to re- run everything. While I had issues trying to run 'terrafor login' in the first instance, the second instance was a smooth sail after I generated the token. 

In the first instance, when attempting to run 'terraform login' it will lunch in bash a wiswing view to generate a token.  However, it does not as expected in Gitpod VSCode in the browser. 
The work around is to mannually generate token 

```
https://app.terraform.io/app/settings/tokens?source=terraform
```
Then create and open files manually here

```
touch + the link provided 
open + the link provided

```
eg 
```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```
While the touch command creates a new file, the open command opens it up for editing.
The new file is empty. The code below is edited and pasted in it. Hence, provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "Replace with your terraform cloud token"
    }
  }
}
```


See [source](https://www.reddit.com/r/Terraform/comments/rtl5ey/can_anyone_please_show_me_show_me_how/?rdt=47689)of code. 
Then open the file
Before I resarted the process I had to delete the resources created in terraform using this [guide](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-destroy)

We have automated this workaround with the  bash script [./bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials)

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






### Create S3 Bucket Using Terraform.
- Create a new ticket in Git Hub
- Open the file called 'main.tf'
- The current code is shown below

```
PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'
AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE'
AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
AWS_DEFAULT_REGION='us-east-1'
```

- Copy the code and paste it below the original code and edit it usinbg the actual key values. Remeember you must keep the old coce with the wrong values because you should never commit your access and secret access keys into Github or Gitpod or anywhere else. **They are private** 

- **Initialize terraform**

- Select 'main.tf'
- Select the Terraform tab in the terminal
- Run  

```
Terraform init
```
in the terminal. 
- Run 
```
terraform apply --auto-approve
```
- A bucket has been created called "lSti4APBkH4sDcrC". This bucket name is not in line with the requirment for S3 bucket


- Go to google browser and search for 'Terraform registry'
- In [Terraform registry](https://registry.terraform.io/) select browse providers> aws> Documentation
- Scroll to S3 simple storage and select 'aws_s3_bucket' from under resources
- Scroll down to 'Example Usage'
- Scroll down to 'Private Bucket With Tags' copy the code
```
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```


- Paste it in 'main.tf' after the third block of code called 'resource' before 'Output' 
- Remove the tag and edit it with 


- Remove the tag and edit it with 

```
resource "aws_s3_bucket" "example" {
  bucket = "random_string.bucket_name.result"
}
```
- Go to the terminal and run 
```
terraform plan
```
- A bucket has been created called ''. This bucket does nbot meet the requirements for mcreating an S3 bucket. 
- **Add AWS providers**

- In [Terraform registry](https://registry.terraform.io/) select browse providers> aws> [Use provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- Copy the code
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}
```

- Remove the first two lines of the new block of code and the last two curly brace.  It will look like the code below. Cut it and paste it after the curly brace that comes at the end if the version (In the first block of code). This is because you can only have a single terraform block

```

    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  
```
**note ran terraform plan --then there was an error. so I ran terraform init** pls delete this sentence
- Run 
```terraform init```
- Run again 
```Terraform plan```
- Select the terraform tab
- Run Terraform plan you will get an error
- Run 
```
e
nv | grep AWS
```


- Select AWS tab
- Run env | grep AWS

- **You will notice that the access key and secret access key are not the same**
- The keys for terraform has not been edited to the current one. To do this 



- In [Terraform registry](https://registry.terraform.io/) select browse providers> aws> [Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

- Scroll down to [Provider configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#provider-configuration)
- Copy the code below and paste it below the first block of code starting with the word'Terraform'

```
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```
- Edit the code with the correct keys see example below
```
provider "aws" {
  access_key = "********************"
  secret_key = "****************************************"
  region     = "us-east-1"
}

```

- Again run
```
terraform plan
```
Now remove the access key and secret access key to avoid commiting them cos they are private. 


- Edit the code below with the correct details and run it in the terminal of the same terraform tab

```
export AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE'
export AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/export K7MDENG/bPxRfiCYEXAMPLEKEY'
AWS_DEFAULT_REGION='us-east-1'
```
- Run 
```
terraform plan
```
- A bucket is created but it is not in line with the requirements for S3 bucket in AWS. 
- Run Terraform apply
AWS_DEFAULT_REGION='us-east-1'
```
- Run 
```
terraform plan
```
- A bucket is created but it is no t in line with the requirements for S3 bucket in AWS. 
- Run Terraform apply
- But it fails. so fix ramdom string
```
- Run 
```
terraform plan
```
- A bucket is created but it is no t in line with the require-ments for S3 bucket in AWS. 
- Run Terraform apply
- But it fails. so fix ramdom string
- Random mstring is in the 4th block of the code in 'main.tf'
- Below is an example of the edited one
```
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length = 32 
  special = true 
  override_special = "%*@"
```

- Also create a proper and unique bucket name. I choose 'my-terraform-bucket-88afor'
- Replace the bucket names in code block 5 and 6 with your unique bucket name. 


Run 
```
terraform plan
```
- Run
```
Terraform apply
```

enter 'yes'

- **To destroy the bucket**

- Run 
```terraform destroy
```
- Type 'yes'



- The initial code is shown below
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

- ** The final code is **
```
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
}

provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length = 32 
  special = true 
  override_special = "%*@"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket naming rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  bucket = "my-terraform-bucket-88afor"
}

output "random_bucket_name" {
  value = "my-terraform-bucket-88afor"
}

```
- Before you commit, cheak all your files and make sure you have not left your access key or secret key any where in your files.
- **Former way of configuring terraform**
  see (guide)[https://developer.hashicorp.com/terraform/language/settings/backends/remote] (under basic confifuration copy and edit code) and this [page](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate#configure-terraform-cloud-integration) under Configure Terraform Cloud integration copy and edit code . 
## Reference

- [Semantic Versioning 2.0.0](https://semver.org/)
- [oh-my-bash](https://github.com/ohmybash/oh-my-bash)
- [What version of Linux am I running?](https://opensource.com/article/18/6/linux-version)
- [Destroy resources and workspaces](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-destroy)
- [can anyone please show me show me how credentials.tfrc.json content looks like with token ?](https://www.reddit.com/r/Terraform/comments/rtl5ey/can_anyone_please_show_me_show_me_how/?rdt=47689)
- [remote](https://developer.hashicorp.com/terraform/language/settings/backends/remote)
- (Migrate state to Terraform Cloud)[https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate]
- [Configure Terraform Cloud integration](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate#configure-terraform-cloud-integration)
- [Terraform Registry](https://registry.terraform.io/)
- [Create a workspace](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-workspace-create)
- [Step 1: Verify the S3 Bucket Name](https://saturncloud.io/blog/troubleshooting-error-after-creating-s3-bucket-with-terraform/#step-1-verify-the-s3-bucket-name)
- [Troubleshooting: Error After Creating S3 Bucket with Terraform](https://saturncloud.io/blog/troubleshooting-error-after-creating-s3-bucket-with-terraform)
- [Bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console)
- [AWS::S3::Bucket](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html)




- fff
- go to chat gpt and ask chat gpt to write a bash script that will generate out the json file credentials.tfrc.json with the jason structure  below and it should use the env var TERRAFORM_CLOUD_TOKEN                                                                   {
  
```  
"credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```
I was not comfortable with the code that was generated so i used the provided one below

```

# Check if the TERRAFORM_CLOUD_TOKEN environment variable is set
if [ -z "$TERRAFORM_CLOUD_TOKEN" ]; then
  echo "Error: TERRAFORM_CLOUD_TOKEN environment variable is not set."
  exit 1
fi

# Generate credentials.tfrc.json with the token 
cat > /home/gitpod/.terraform.d/credentials.tfrc.json << EOF 
{
  "credentials": {
    "app.terraform.io": {
      "token": "'"$TERRAFORM_CLOUD_TOKEN"'"
    }
  }
}
EOF

echo "credentials.tfrc.json has been generated."
```

## Note
- **To delete tag 0.2.0 run** 
```
git tag -d 0.2.0
```
**Then run**
```
git push --delete origin 0.2.0
```
then go to GitHub and confirm it.
