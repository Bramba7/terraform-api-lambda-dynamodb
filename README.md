# Terraform-api-lambda-dynamodb

## Schematic:

![schematic](images/schematic.jpeg)

## Overview of the GitHub repository:

```zsh
terraform-api-lambda-dynamodb
├── modules              # → Folder containing all the AWS structures. of the project
│ ├── vpc                # → VPC, Subnets (private and public), IGW, Tables, SG...
│ │ ├── outputs.tf
│ │ ├── variables.tf
│ │ └── main.tf
│ ├── dynamoDB           # → Dynamodb table and fist data on Data Base.
│ │ ├── outputs.tf
│ │ ├── variables.tf
│ │ └── main.tf
│ ├── api                # → API GateWay POST and GET- Method Execution
│ │ ├── outputs.tf
│ │ ├── variables.tf
│ │ └── main.tf
│ ├── iamRole            # → AWS IAM role and policy
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ │ └── main.tf
│ └── lambda             # → Get and Put Lambda configuration
│ ├── outputs.tf
│ ├── variables.tf
│ └── main.tf
├── PUT.zip
│ └── index.js           # → JavaScript code for the Lambda put: Code
├── GET.zip
│ └── index.js           # → JavaScript code for the Lambda get: Code
├── main.tf              # → File responsible for AWS authentication, and also for calling all modules.
└── main.tfvars          # → Contains variables, and settings for the structure.
```

## Getting Started

These instructions will cover usage information and for the docker container

### Prerequisites

In order to run this project it is necessary to install terraform and AWS-CLi:

Terraform:

- [Windows](https://www.terraform.io/downloads.html)
- [OS X](https://www.terraform.io/downloads.html)
- [Linux](https://www.terraform.io/downloads.html)

AWS:

- [Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)
- [OS X](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)
- [Linux](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

### Clone this repository (linux or macOs)

```sh
git clone https://github.com/Bramba7/terraform-api-lambda-dynamodb.git
cd terraform-api-lambda-dynamodb
```

### Configuring credentials for AWS

```sh
aws configure
```

### Create a bucket on AWS

Replace the word "mybucket for the name of your bucket, and the us-west-1 region with your preferred region.
<br><font color="red"><b> Attention the name of your bucket must be a unique name!!!!</b> </font>

```sh
aws s3 mb s3://mybucket --region us-west-1
```

### Edit the code with your information

<dl>
  <dt><b>First Step</b></dt>
  <dd> Open the GET.zip, and PUT.zip files. After unzipping the files, open the index.js files, and replace the lines region: "us-west-2" for your preferred aws region.</dd>
  <dt><b>Second Step</b></dt>
  <dd>After change the index.js region go to project.tfvars and also change the region and the environment name. </dd>
  <dt><b>Last Step</b></dt>
  <dd>After completing the previous steps open the file `project.tf`, and fill this section with your data from the AWS S3 bucket as in the code below:<dd>
</dl>

```
terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    bucket = "bucket's name"
    key    = "Folder's name /terraform.tfstate"
    region = "preference region"
    acl = "private"
    encrypt = true
  }
}
```

### Initialize terraform on the directory

```sh
terraform init
```

### Execute terraform project

For more agility you can use the command `--auto-approve` to skip the execution confirmation.

```sh
terraform apply -var-file="project.tfvars"
```

### Delete terraform project

For more agility you can use the command `--auto-approve` to skip the execution confirmation.

```sh
terraform destroy -var-file="project.tfvars"
```

## Test API Gateway on Aws Console

After login in your AWS account go to API Gateway Service. Or click on the link below:

- [N. Virginia](https://console.aws.amazon.com/apigateway/main/apis?region=us-east-1)
- [Ohio](https://us-east-2.console.aws.amazon.com/apigateway/main/apis?region=us-east-2#)
- [N. California](https://us-west-1.console.aws.amazon.com/apigateway/main/apis?region=us-west-1)
- [Oregon](https://us-west-2.console.aws.amazon.com/apigateway/main/apis?region=us-west-2)

### POST test

Go to **APIs>UsersApi>Resources>POST**  
Click on Client TEST (There is a little ⚡ )  
On the Request Body type:

```json
{
  "id": "2",
  "fistname": "Marry",
  "lastname": "Johnson"
}
```

And than click on TEST

### GET test

Go to **APIs>UsersApi>Resources>GET**  
Click on Client TEST (There is a little ⚡ )  
Type the number 1 or 2 on Path {id} and Click on Test
