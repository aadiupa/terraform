variable "sg_ports" {
  type        = list(number)
  description = "list of ingress"
  default     = [8200, 8300, 8400, 8500]
}
