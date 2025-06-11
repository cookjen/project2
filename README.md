# Automated Minecraft Server Setup


## Background


This GitHub contains code that provisions, configures, and sets up a Minecraft server using AWS, Terraform, and bash scripts. Below, I have written instructions that will teach you how to configure your AWS credentials and deploy the Terraform configuration to have a running Minecraft server you can connect to. The tutorial also covers how to connect to the server once it is running. Note that the tutorial is for people who use AWS Academy Learner Labs.

## Pipeline Diagram

 ![IMG_7162](https://github.com/user-attachments/assets/f2cb0b36-ff08-4361-968a-1dbca74a7a5c)


## Prerequisites


Before beginning the tutorial, you will need to install the following if you don't already have them:


- AWS CLI
- Terraform


Follow the instructions in the links below to download both the AWS CLI and the Terraform CLI:


- Install the AWS CLI here: [Installing or updating the latest version of the AWS CLI - AWS Command Line Interface (amazon.com)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install the Terraform CLI here: [Install Terraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

If you do have Terraform and AWS CLI, make sure you have Terraform version 1.12.1 or newer and make sure you have AWS CLI version 2.27.25 or newer.

## Tutorial


1. If you haven't already, go to the **Prerequisites** section and follow the instructions to install the AWS CLI and the Terraform CLI.
2. Go to the Launch AWS Academy Learner Lab page and click on **Start Lab**.
3. Then click on **AWS Details** in the top right corner of the same page.
4. Create the file ~/.aws/credentials and copy the credentials from **AWS Details** into the file. Don't forget to save!
Alternatively, you can use the CLI to set up the variables using the following command:
`aws configure set <variable> "<value>"`.
This will need to be run three times to ensure that the aws_access_key_id, aws_secret_access_key, and aws_session_token are all set.
Below is an example of what one of these commands might look like:
`aws configure set aws_access_key_id "ASIAQ3SUJJBSZSG4BANA"`.
5. Now that your credentials are set, we can deploy the Terraform configuration. Initialize the directory of the new configuration using the following command:
`terraform init`.
6. Then you can apply and approve the Terraform configuration using the following command:
`terraform apply -auto-approve`.
7. Now the Minecraft server should be up and running. To connect to it using Nmap, insert the public IP outputted by the Terraform configuration into the following command, then run the command:
`nmap -sV -Pn -p T:25565 <instance_public_ip>`.
Now you can see the server is up and running! Alternatively, you can connect to the server using the Minecraft Client by starting up Minecraft Java Edition, going to **Multiplayer**, clicking on **Direct Connection**, inputting the public IP that was outputted by the Terraform configuration, and clicking **Join Server**.

## Resources

These are the resources I used to create the Terraform configuration and bash scripts.

- [Build infrastructure](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)
- [How to Create AWS EC2 Instance Using Terraform](https://spacelift.io/blog/terraform-ec2-instance)
- [How to create an SSH key in Terraform?](https://stackoverflow.com/questions/49743220/how-to-create-an-ssh-key-in-terraform)
- [How to upload local files to Amazon EC2 instance using Terraform](https://www.howtoforge.com/how-to-upload-local-files-to-amazon-ec2-instance-using-terraform/)
- [Resource: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [Setting up a Minecraft Java server on Amazon EC2](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)
- [Terraform: How to execute shell/bash scripts](https://www.slingacademy.com/article/terraform-how-to-execute-shell-bash-scripts/)
- [Terraform: How to generate SSH keys](https://www.slingacademy.com/article/terraform-how-to-generate-ssh-keys/)
- [Query data with outputs](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-outputs)
