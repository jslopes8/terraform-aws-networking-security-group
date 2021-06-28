resource "aws_security_group" "main" {
    count = var.create ? 1 : 0

    name        = var.name
    vpc_id      = var.vpc_id

    tags    = merge(
        {
            "Name"  =   var.name
        },
        var.default_tags
    )
}

resource "aws_security_group_rule" "main" {
    count   =   var.create ? length(var.rule) : 0

    security_group_id   = aws_security_group.main.0.id

    description                 = lookup(var.rule[count.index], "description", null)
    type                        = lookup(var.rule[count.index], "type", null)
    from_port                   = lookup(var.rule[count.index], "from_port", null )
    to_port                     = lookup(var.rule[count.index], "to_port", null)
    protocol                    = lookup(var.rule[count.index], "protocol", null)
    cidr_blocks                 = lookup(var.rule[count.index], "cidr_blocks", null)
    source_security_group_id    = lookup(var.rule[count.index], "sec_group_id", null)
}
resource "aws_security_group_rule" "egress" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = [ "0.0.0.0/0" ]
    description       = "All egress traffic"
    security_group_id = aws_security_group.main.0.id
}
