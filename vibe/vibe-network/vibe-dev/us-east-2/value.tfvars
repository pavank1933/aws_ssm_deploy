region            = "us-east-2"

created_by        = "Ramana-DevOps"

aws_account       = "117843297914"

app_name          = "vibe"

app_environment   = "dev"

region_tag        = "US-OH"

app_version       = "1.0.0.0"

monitor           = "yes"

cost_center       = "ops"

role              = "network"

reference_id      = "xv173"



vpc_cidr = "10.180.0.0/19"

subnet_info = {
  public = [
    {
      az = "a"
      newbits = "3"
      netnum = "1"
    },
    {
      az = "b"
      newbits = "3"
      netnum = "2"
    }
  ]
  private = [
    {
      az = "a"
      newbits = "3"
      netnum = "3"
    },
    {
      az = "b"
      newbits = "3"
      netnum = "4"
    },
    {
      az = "c"
      newbits = "3"
      netnum = "5"
    },
    {
      az = "a1"
      newbits = "3"
      netnum = "6"
    }
  ]
}