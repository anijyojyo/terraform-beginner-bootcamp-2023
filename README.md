# Terraform Beginner Bootcamp 2023

## Table of Contents

- [Semantic Versioning](#semantic-versioning)

- [Install the Terraform CLI] (#install-the-terraform-cli)
    -   [Considerations with the Terraform CLI changes]
        (#considerations-with-the-terraform-cli-changes)
-   [AWS CLI Installation]
-   [Terraform Basics]
-   [Terraform Basics]
-   [Issues with Terraform Cloud Login and Gitpod Workspace]

## Semantic Versioning



This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format :
**MAJOR.MINOR.PATCH** , e.g. `1.0.1`

-   **MAJOR** version when you make incompatible API changes
-   **MINOR** version when you add functionality in a backward compatible manner
-   **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.


## Considerations with the Terraform CLI changes

The terraform installation instructions have changed due to gpg keyring changes.
So we needed to refer to the latest install CLI instructions via Terraform Documentation and
change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distributions

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.

[How to check OS version in Linux](https://opensource.com/article/18/6/linux-version)

Example of Checking OS Version:

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

While fixing the Terraform CLI gpg depreciation issues we noticed that bash scripts steps were a 
considerable amount of more code. So we decided to create a bash script, to install a Terraform CLI.

This bash script is located here :[./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

-   This will keep the Gitpod Task File ([gitpod.yml](.gitpod.yml))tidy.
-   This allows us an easier time to debug and execute manually Terraform CLI install
-   This will allow better portability with other projects that need to install Terraform CLI.

### Shebang

A Shebang ( pronounced as Sha-bang) tells the bash script what program that will interpret the script e.g. `#!/usr/bin/env bash`

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script e.g. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

e.g. `source ./bin/install_terraform_cli`


#### Linux Permissions Considerations 

Linux permissions works as follows:

In order to nake our bash scripts executable we need to change Linux permission for the file to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively:
```sh
chmod 744 ./bin/install_terraform_cli

```
https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init,Command)

We need to be careful when using the init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working with Env Vars

### env command

We can list out all Environment Variables ( Env Vars) using the `env` command.

We can filter specific en vars using grep e.g. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world`

In the terminal we unset `unset HELLO`

We can set an env var temporarily when just running a command 

```sh

HELLO= 'world' ./bin/print_message

```
Within a bash script we can set env without writing export e.g.

```sh

#!/usr/bin/env bash

HELLO='world'

echo $HELLO

```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode, it will not be aware of env vars that you have set in another window

If you want Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile, e.g. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'

```
All future workspaces launched will set the env vars for all bash terminals opened in those Workspaces.

You can also set the en vars in the `gitpod.yml` but this can contain only non-sensitive env vars.


###  AWS CLI Installation

AWS CLI is installed for this project via the bash script [` ./bin/install_aws_cli `](./bin/install_aws_cli)

[Getting Started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following command AWS CLI command:

```sh
aws sts get-caller-identity

```
If it is successful you should see a json payload return that looks like this :
```json

{
    "UserId": "AMSC4EI7OL53MG9CHZRWB",
    "Account": "999999999999",
    "Arn": "arn:aws:iam::999999999999:user/terraform-beginner"
}

```

We will need to generate AWS credentials from IAM user in order to use the AWS CLI.

[IAM user creation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)


## Terraform Basics


### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are interface to APIs that will allow you to create resources in terraform.

- **Modules** are a wa to make large amount of terraform code modular, portable and sharable.

[Random Terraform Providers](https://registry.terraform.io/providers)

### Terraform Console

We can see list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to to donwload the binaries for the terraform providers that we will use in this project.

#### Terraform Plan

`terrafor plan`

This will generate out a changeset , about the state of our infrastructure and what will be changed.

We can output this changeset i.e., "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply 

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

If we want to automatically approve we can provide the auto approve flag e.g., `terraform apply --auto-approve`.

#### Terraform Destroy

`terraform destroy`

This will destroy resources.

You can also use the auto approve flag to skip the approve prompt e.g., `terraform apply auto-approve`

#### Terraform Lock Files

`terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The terraform lock file **should be committed** to your Version Control System (VSC) e.g., Github.

#### Terraform State Files

`terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be committed** to your VSC.

This file can contain sensitive data.

If you lose this file , you will lose knowing the state of your infrastructure.

`terraform.tfstate.backup` is the file of previous state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace 

When attempting to run `terraform login` it will launch in bash a wiswig view to generate a token. However it does not work expected in Gitpod VSCode in the browser.

The workaround is to manually generate a token in Terraform cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login

```


We have automated the workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)