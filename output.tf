output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = "${module.supply-registry-service-policy.arn}"
}
