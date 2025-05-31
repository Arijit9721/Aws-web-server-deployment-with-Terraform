# making the vpc
resource "aws_vpc" "test_vpc1" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "test"
    }
}

# making a subnet in the vpc
resource "aws_subnet" "test_subnet1" {
    vpc_id = aws_vpc.test_vpc1.id
    cidr_block  = var.subnet_cidr
    availability_zone = var.subnet_az
    map_public_ip_on_launch = true

    tags = {
        Name = "test"
    }
}

# making a key-pair for ssh into ec2
resource "aws_key_pair" "test_key" {
    key_name = "test_key"
    public_key =  file(var.public_key) 
}

# creating the internet gateway on the subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc1.id

  tags = {
    Name = "test"
  }
}

# creating a route from the subnet to the internet gateway
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.test_vpc1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
    Name = "test"
  }
}

# now link the route table to the subnet
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.test_subnet1.id
    route_table_id = aws_route_table.RT.id
}

# creating a security group
resource "aws_security_group" "websg" {
    name = "web"
    vpc_id = aws_vpc.test_vpc1.id

    ingress {
        description = "Allow HTTP requests from external sources"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow SSH requests from external sources"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "test"
    }
}

# creating the ec2 web server
resource "aws_instance" "test_server"  {
    ami = "ami-0261755bbc8c4a84"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.test_subnet1.id
    key_name = aws_key_pair.test_key.key_name 
    vpc_security_group_ids = [aws_security_group.websg.id]

    # connecting to the server using ssh
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file(var.private_key)
        host = self.public_ip
    }

    # copying the app from local to the web server
    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
    }

    # installing and updating all the dependencies 
    provisioner "remote-exec" {
        inline = [
            "echo 'connection to the web server successful'",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "sudo pip install flask",
            "sudo python3 app.py &",
        ]
    }

    tags = {
        Name = "test"
    }
}
