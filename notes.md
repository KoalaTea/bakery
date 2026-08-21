# Tooling
## Terraform
Infrastructure as Code. For deploying infrastructure.
## Ansible
Configuration as Code. For managing infrastructure, its configuration.
## Packer
For building images to be used by Terraform.

### Why and how
You would build your images, or configure your bare metal servers with Ansible. You would use Packer to organize and orchestrate the building of images. You would use Terraform to actually deploy the images with any specific configuration variables for a sepcific deploy.
It can be a little confusing but the intention is to be able to start a fresh machine instead of upgrading and making changes for a server over time. Treat them like cattle. You bring kill what you dont need and bring in new ones. So the Packer and Ansible build reusable images that you can deploy multiple of with a few parameters that stay the same the entire time its up. Then Terraform can configure those variables and state you want something like 4 servers.