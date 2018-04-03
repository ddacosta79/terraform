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
  service    = "cloudantNoSQLDB"
  plan       = "Lite"
  tags       = ["cluster-service", "cluster-bind"]
}

#########################################################
# Output
#########################################################
output "The Cloudant service ID" {
  value = "${ibm_service_instance.id}"
}

output "The Cloudant Service Credentials" {
  value = "${ibm_service_instance.credentials}"
}

output "The Cloudant Service Keys" {
  value = "${ibm_service_instance.service_keys}"
}
