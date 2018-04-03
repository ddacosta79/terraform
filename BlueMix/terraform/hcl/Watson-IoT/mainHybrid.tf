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
output "The IoT service ID" {
  value = "${ibm_service_instance.service_instance.id}"
}

output "The IoT Service Credentials" {
  value = "${ibm_service_instance.service_instance.credentials}"
}

output "The IoT Service Keys" {
  value = "${ibm_service_instance.service_instance.service_keys}"
}
