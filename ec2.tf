
#creating ec2 instance
resource "aws_instance" "provisioners" {

    ami = "ami-090252cbe067a9e58"
    vpc_security_group_ids = ["sg-014f3947b6035bd6d"]
    instance_type = "t3.micro"

#provosioners will run along with the resources creation 
#it will not run if there is already resource created. 
    provisioner "local-exec" {
        command = "echo ${self.private_ip} > private.ip.txt" #self is the aws_instance.web

}

#to run the remote provosioner we need to connect to SSH so first we setup the connection and then do the provisioner 

 connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip 
  }
 
  provisioner "remote-exec" {
    inline = [
      #give the list of commands
      "sudo dnf install ansibile -y ",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }


}
