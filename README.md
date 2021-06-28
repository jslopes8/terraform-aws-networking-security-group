# AWS Terraform - Security Group
Terraform module irá provisionar os seguintes recursos:

*[Security Gruop](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
*[Security Group Rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)


**_NOTA:_** Este templante provisionará um recurso autonomo com uma regra de engress. Potanto, você não precisará definir uma regra com o tipo engress.


## Usage
###  Port SSH
`Caso de uso`: Segurity Group com um regra para a porta SSH.
```bash
module "sg" {
  source = "git@github.com:jslopes8/terraform-aws-networking-security-group.git?ref=v2.0"

  name = "EC2Bastion"
  vpc_id = data.aws_subnet_ids.subnet_ids.id

  rule = [
    {
      type        = "ingress"
      to_port     = "22"
      from_port   = "22"
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  ]

  default_tags = {
    Name        = "EC2 Instance Bastion"
    Envronment  = "PoC"
  }
}
```
### Port 80/443
`Caso de uso`: Segurity Group com duas regras; uma pra porta 80 e outra para porta 443.
```bash
module "sg" {
  source = "git@github.com:jslopes8/terraform-aws-networking-security-group.git?ref=v2.0"

  name = "ALBWebServer"
  vpc_id = data.aws_subnet_ids.subnet_ids.id

  rule = [
    {
      type        = "ingress"
      to_port     = "80"
      from_port   = "80"
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    },
    {
      type        = "ingress"
      to_port     = "443"
      from_port   = "443"
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }
  ]

  default_tags = {
    Name        = "ALB Web Server"
    Envronment  = "PoC"
  }
}
```
### Port 22
`Caso de uso`: Segurity Group com associado com outro Segurity Group.
```bash
module "sg" {
  source = "git@github.com:jslopes8/terraform-aws-networking-security-group.git?ref=v2.0"

  name = "EC2WebServer"
  vpc_id = data.aws_subnet_ids.subnet_ids.id

  rule = [
    {
      type          = "ingress"
      to_port       = "22"
      from_port     = "22"
      protocol      = "tcp"
      sec_group_id  = "sg-123456"
    }
  ]

  default_tags = {
    Name        = "EC2 WebServer"
    Envronment  = "PoC"
  }
}
```

## Requirements

| Name | Version|
|------|--------|
| aws | 3.* |
| terraform | 0.15.*| 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Variables Inputs
| Name | Description | Required | Type | Default |
| ---- | ----------- | -------- | ---- | ------- |
| name | O nome do Segurity Group. | `yes` | `string` | ` ` |
| vpc_id | O id da VPC. |`yes` | `string` | ` ` |
| rule | Bloco dinamico que prover a regra do segurity group. Segue abaixo mais detalhes. | `yes` | `list` | `[ ]` |
| default_tags | Um map de chave valor para tagueamento do recursos. | `yes` | `map` | `{ }` | 

O argumento `rule` possui os seguintes atributos;
- `description`: (Opcional) Uma descrição para o Segurity Group. Por padrão é `Managed by Terraform`.
- `type`: (Obrigatorio) O tipo da regra sendo criada.
- `to_port`: (Obrigatorio)
- `from_port`: (Obrigatorio) Porta de início (ou número do tipo ICMP se o protocolo for "icmp" ou "icmpv6").
- `protocol`: (Obrigatorio) Protocol. Valores validos, icmp, icmpv6, tcp, udp, ou all.
- `cidr_blocks`: (Opcional) Lista de blocos CIDR. Não pode ser especificado com `sec_group_id` ou sem.
- `sec_group_id`: (Opcional) O Id do security group para permitir acesso to/from. Não pode ser especificado com `cidr_blocks` ou sem.


## Variable Outputs
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| Name | Description |
| ---- | ----------- |
| id | O id do Security Group criado.|