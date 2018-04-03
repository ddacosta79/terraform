#########################################################
# Define the template variables
#########################################################

variable "space" {
  description = "cloud organization space"
}

data "ibm_space" "spacedata" {
  space = "${var.space}"
  org   = "david.dacosta@pt.ibm.com"
}

variable "name" {
  description = "Cloud service unique name"
}

#########################################################
# resource
#########################################################

resource "ibm_service_instance" "service_instance" {
  name       = "${var.name}"
  space_guid = "${data.ibm_space.spacedata.id}"
  service    = "iotf-service"
  plan       = "iotf-service-free"
  tags       = ["cluster-service", "cluster-bind"]
}
#########################################################
# Output
#########################################################
output "Watson Visual Recognition service ID" {
  value = "${ibm_service_instance.service_instance.id}"
}

output "Watson Visual Recognition Service Credentials" {
  value = "${ibm_service_instance.service_instance.credentials}"
}

output "Watson Visual Recognition Service Keys" {
  value = "${ibm_service_instance.service_instance.service_keys}"
}
