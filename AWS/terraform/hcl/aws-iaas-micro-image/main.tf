resource "aws_instance" "example" {
  ami           = "ami-965e6bf3"
  instance_type = "t2.micro"
}
