variable "profile" {
  description = "Profile name"
  type = "string"
}

variable "service_name" {
  description = "Service name"
  type = "string"
  default = "supply-registry-service"
}

variable "c_team" {
  description = "Team name"
  type = "string"
  default = "captain-supply"
}

variable "c_service" {
  description = "Service name"
  type = "string"
  default = "InstanceProfile - Supply-Registry-Service"
}

variable "centralized-logging-policy-arn" {
  description = "Centralized-Logging policies arn"
  type = "string"
}

variable "autoscaling-elb-policy-arn" {
  description = "Autoscaling-ELB policies arn"
  type = "string"
}

variable "secret-manager-application-policy-arn" {
  description = "Secret-Manager-Application policies arn"
  type = "string"
}
