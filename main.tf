data "template_file" "policy_document" {
  template = "${file(format("%s/%s-policy.json", var.profile, var.service_name))}"
}

#Supply-Registry Service Policies
module "supply-registry-service-policy" {
  source       = "git::ssh://git@sshbitbucketdc.careem-internal.com:7999/devops/iac.git//terraform/modules/iam/iam-policy?ref=current-stable"
  name         = "${format("%s-%s-policy", var.profile, var.service_name)}"
  path         = "/"
  description  = "${format("IAM policy for %s", var.service_name)}"
  policy       = "${data.template_file.policy_document.rendered}"
}

#Instance Profile
module "supply-registry-service-instance-profile" {
  source       = "git::ssh://git@sshbitbucketdc.careem-internal.com:7999/devops/iac.git//terraform/modules/iam/iam-role/instance?ref=current-stable"
  service_name = "${var.service_name}"
  cteam        = "${var.c_team}"
  cservice     = "${var.c_service}"
  cenv         = "${var.profile}"
}

#Supply-Registry-Service Policy Attachment
resource "aws_iam_role_policy_attachment" "supply_registry_service_policy_attachment" {
  role       = "${module.supply-registry-service-instance-profile.role_name}"
  policy_arn = "${module.supply-registry-service-policy.arn}"
}

#Centralized-Logging Policy Attachment
resource "aws_iam_role_policy_attachment" "centralized_logging_policy_attachment" {
  role       = "${module.supply-registry-service-instance-profile.role_name}"
  policy_arn = "${var.centralized-logging-policy-arn}"
}

#Autoscaling-ELB Policy Attachment
resource "aws_iam_role_policy_attachment" "autoscaling_elb_policy_attachment" {
  role       = "${module.supply-registry-service-instance-profile.role_name}"
  policy_arn = "${var.autoscaling-elb-policy-arn}"
}

#Secret-Manager-Application Policy Attachment
resource "aws_iam_role_policy_attachment" "secret_manager_application_policy_attachment" {
  role       = "${module.supply-registry-service-instance-profile.role_name}"
  policy_arn = "${var.secret-manager-application-policy-arn}"
}
