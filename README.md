# Introduction to Packer
[Packer](https://www.packer.io/) is an open source tool that enables you to create identical machine images for multiple platforms from a single source template. 
A most common use case is creating "golden images" that teams across an organization can use in cloud infrastructure.

This contains the packer file for the creation of custom ami for ubuntu 20.04 (focal) 64bit amd  on aws.

To run this :

 1. Configure the aws cli using aws configure.`aws configure`
 2. Clone this repo `git clone https://github.com/learning packer.git`
 3. Open Terminal in the cloned folder and got to the folder of ami you want. For eg. If you need an AMI of ubuntu 20.04 with git, go to ubuntu-20.04-with-git
 4. Edit `variables.pkvars.hcl` file with values for the variables for the ami name and the region you want the ami to be created. Default ami_name is ` "ubuntu-focal-20.04-amd64-with-git"` and region in which ami is created is `us-east-1`
`ami_name = "ubuntu-focal-20.04-amd64-with-git"`
`region = "us-east-1"`
 5. To create the AMI, run the command
`packer build --var-file=variables.pkvars.hcl build.pkr.hcl`
