# Create a virtual server
resource "ibm_compute_vm_instance" "edpserver01" {
hostname = "server001"
domain = "example.com"
os_reference_code = "CENTOS_6_64"
datacenter = "ams03"
network_speed = 10
cores = 1
memory = 1024
}
