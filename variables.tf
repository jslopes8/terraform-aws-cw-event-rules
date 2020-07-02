variable "create" {
    type    = bool
    default = true
}
variable "name" {
    type    = string
}
variable "description" {
    type    = string
    default = null
}
variable "role_arn" {
    type    = string
    default = null
}
variable "schedule" {
    type    = string
    default = null
}
variable "is_enabled" {
    type    = bool
    default = true
}
variable "event_pattern" {
    type    = any
    default = []
}
variable "add_targets" {
    type    = any
    default = []
}
variable "default_tags" {
    type    = map(string)
    default = {}
}