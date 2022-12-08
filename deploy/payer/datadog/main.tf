
module "dd-sandbox-bus3" {
    source = "../../../module//datadog"

    providers = {
      aws = aws.sandbox-bus3
     }
    host_tags =  [
          "aws_account:123456789012",
          "cloud_account:aws_123456789012",
          "school:bus3",
        ]
}



module "dd-stage-bus3" {
    source = "../../../module//datadog"

    providers = {
      aws = aws.stage-bus3
     }
    host_tags =  [
          "aws_account:123456789012",
          "cloud_account:aws_123456789012",
          "school:bus3",
        ]
}


module "dd-prod-bus2" {
    source = "../../../module//datadog"

    providers = {
      aws = aws.prod-bus2
     }
    host_tags =  [
          "aws_account:123456789012",
          "cloud_account:aws_123456789012",
          "school:bus2",
        ]
}

module "dd-prod-bus1" {
    source = "../../../module//datadog"

    providers = {
      aws = aws.prod-bus1
     }
    host_tags =  [
          "aws_account:123456789012",
          "cloud_account:aws_123456789012",
          "school:bus1",
        ]
}

module "dd-prod-bus3" {
    source = "../../../module//datadog"

    providers = {
      aws = aws.prod-bus3
     }
    host_tags =  [
          "aws_account:123456789012",
          "cloud_account:aws_123456789012",
          "school:bus3",
        ]
}

module "dd-enterprise-master-payer" {
    source = "../../../module//datadog"

    providers = {
      aws = aws.enterprise-master-payer
     }
    host_tags =  [
          "aws_account:123456789012",
          "cloud_account:aws_123456789012",
          "school:group",
        ]
}
