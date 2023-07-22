variable "chart_name" {
  type        = string
  description = "Name of the helm chart"
}

variable "release_name" {
  type        = string
  description = "Name of the release"
}

variable "repository" {
  type        = string
  description = "Helm chart repository"
}

variable "chart_version" {
  type        = string
  default     = ""
  description = "Chart version"
}

variable "namespace" {
  type        = string
  description = "Namespace for the deployment"
}

variable "create_namespace" {
  type        = bool
  description = "Whether to create the namespace"
}

variable "wait" {
  type        = bool
  default     = false
  description = "Whether to wait fro deployment to finish"
}

variable "set" {
  type = list(object({
    name  = string
    value = string
  }))
}