#########################################################
# Define the variables
#########################################################
variable "datacenter" {
  description = "Softlayer datacenter where infrastructure resources will be deployed"
}

variable "hostname" {
  description = "Hostname of the virtual instance to be deployed"
}



# Create a virtual server
resource "ibm_compute_vm_instance" "myserver" {
hostname                 = "${var.hostname}"
domain = "example.com"
os_reference_code = "CENTOS_6_64"
datacenter               = "${var.datacenter}"
network_speed = 10
cores = 1
memory = 1024
}

#########################################################
# Output
#########################################################
output "The server IP" {
  value = "${ibm_compute_vm_instance.myserver.ipv4_address_private}"
}
