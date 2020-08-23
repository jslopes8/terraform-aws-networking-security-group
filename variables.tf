variable "create" {
    type = bool 
    default = true 
}
variable "name" {
    type = string
}
variable "rule" {
    type = any 
    default = []
}
variable "vpc_id" {
    type = string
}
variable "default_tags" {
    type    = map(string)
    default = {}
}