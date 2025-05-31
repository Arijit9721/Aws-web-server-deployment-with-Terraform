# 🌐 AWS Web Server Deployment with Terraform

This project provisions a complete infrastructure on AWS using Terraform to deploy a simple Python Flask web application (`app.py`) on an EC2 instance. The infrastructure includes VPC, subnet, internet gateway, route tables, security groups, SSH key-pair setup, and a provisioned EC2 instance.



## 🚀 Features

🔹 Fully automated AWS environment setup  
🔹 Custom VPC with public subnet  
🔹 Internet access via Internet Gateway and Route Table  
🔹 Secure EC2 deployment with SSH and HTTP access  
🔹 Auto deployment of Python Flask app via Terraform `provisioner`  
🔹 Key-based SSH authentication



## ⚙️ Resources Created

- ✅ VPC  
- ✅ Public Subnet  
- ✅ Internet Gateway  
- ✅ Route Table + Association  
- ✅ Security Group (for SSH & HTTP)  
- ✅ Key Pair (for EC2 access)  
- ✅ EC2 instance with `app.py` deployed


## 📌 Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI with credentials configured (`~/.aws/credentials`)
- A valid SSH key pair:
  - `public_key` (added to `variables.tf`)
  - `private_key` (used locally for provisioning)



## 🛠️ How to Use

1. **Clone the repository**

```bash
git clone <your-repo-url>
cd <your-project-directory>
```
2. **Set the variables in the variables. tf  and terraform.tfvars file**
 - Vpc_Cidr_block
 - Subnet_Cidr_block
 - subnet_az
 - public_key
 - private_key
 
 3. **Initialize Terraform**
	 ``` bash
	 terraform init
	 ```
 4. **Preview the plan**
	 ``` bash
	 terraform plan
	 ``` 

5. **Apply the infrastructure**
	``` bash
	terraform apply
	```

##  📄 License

This project is open source and available under the MIT License.



