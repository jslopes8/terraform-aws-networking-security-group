# terraform-aws-networking-security-group


### Usage
```hcl
module "sg" {
    source = "git@github.com:jslopes8/terraform-aws-networking-security-group.git?ref=v2.0"

    name = "EC2-Bastion"
    vpc_id = data.aws_subnet_ids.subnet-ids.id

    rule = [
        {
            type        = "ingress"
            to_port     = "22"
            from_port   = "22"
            protocol    = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }
    ]
    default_tags = local.tags
}

```


