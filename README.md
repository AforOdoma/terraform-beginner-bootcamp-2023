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

## Reference

- [Semantic Versioning 2.0.0](https://semver.org/)
- [oh-my-bash](https://github.com/ohmybash/oh-my-bash)
- [What version of Linux am I running?](https://opensource.com/article/18/6/linux-version)



