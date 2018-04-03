#########################################################
# Define the variables
#########################################################
variable "datacenter" {
  description = "Softlayer datacenter where infrastructure resources will be deployed"
}

variable "hostname" {
  description = "Hostname of the virtual instance to be deployed"
}

#########################################################
#resource
#########################################################

# Create a virtual server
resource "ibm_compute_vm_instance" "myserver" {
hostname                 = "${var.hostname}"
os_reference_code        = "CENTOS_7_64"
domain                   = "cam.ibm.com"
datacenter               = "${var.datacenter}"
network_speed            = 10
hourly_billing           = true
private_network_only     = false
cores                    = 1
memory                   = 1024
disks                    = [25]
dedicated_acct_host_only = false
local_disk               = false
}



# Create the installation script
provisioner "file" {
  content = <<EOF
#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

LOGFILE="/var/log/install_nodejs.log"

echo "---start installing node.js---" | tee -a $LOGFILE 2>&1

yum install gcc-c++ make -y                                                        >> $LOGFILE 2>&1 || { echo "---Failed to install build tools---" | tee -a $LOGFILE; exit 1; }
curl -sL https://rpm.nodesource.com/setup_7.x | bash -                             >> $LOGFILE 2>&1 || { echo "---Failed to install the NodeSource Node.js 7.x repo---" | tee -a $LOGFILE; exit 1; }
yum install nodejs -y                                                              >> $LOGFILE 2>&1 || { echo "---Failed to install node.js---"| tee -a $LOGFILE; exit 1; }

echo "---finish installing node.js---" | tee -a $LOGFILE 2>&1

EOF

  destination = "/tmp/installation.sh"
}

# Execute the script remotely
provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/installation.sh; bash /tmp/installation.sh",
  ]
}
}

#########################################################
# Output
#########################################################
output "The server IP" {
  value = "${ibm_compute_vm_instance.myserver.ipv4_address_private}"
}
