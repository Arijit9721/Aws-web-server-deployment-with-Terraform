terraform{
    required_provider {
        aws = {
            provider = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region ="us-east -1"
}