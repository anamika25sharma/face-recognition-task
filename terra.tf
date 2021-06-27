provider "aws" {
	region = "ap-south-1"
	access_key = "YOUR KEY"
	secret_key = "YOUR KEY"
	
 }
resource "aws_instance"  "os1" {
	ami = "ami-0ad704c126371a549"
        availability_zone = "ap-south-1a"
	instance_type = "t2.micro"
	tags = {
		Name = "first OS from terraform"
	}
}
resource "aws_ebs_volume" "example" {
  	 availability_zone = "${aws_instance.os1.availability_zone}"
 	 size             =5

 	 tags = {
   	 Name = "storage box"
  }
}

resource "aws_volume_attachment" "ebs_att"{
  	device_name= "/dev/xvdc" 
  	volume_id = "${aws_ebs_volume.example.id}"    
  	instance_id = "${aws_instance.os1.id}"
	force_detach = true
}


output "AZ" {
       value = aws_instance.os1.availability_zone
}
output "os1_ip" {
       value = aws_instance.os1.public_ip
}


output "os1_id" {
       value = aws_instance.os1.id
}
