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

resource "ibm_service_instance" "service_instance" {
  name       = "${var.name}"
  space_guid = "${data.ibm_space.spacedata.id}"
  service    = "IBMAnalyticsEngine"
  plan       = "lite"
  tags       = ["cluster-service", "cluster-bind"]
}
