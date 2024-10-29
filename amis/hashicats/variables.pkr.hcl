variable "owner" {
  type        = string
  description = "Owner tag to which the artifacts belong"
  default     = "likz"
}

variable "aws_region" {
  type        = string
  description = "AWS Region for image"
  default     = "ap-southeast-1"
}

variable "aws_instance_type" {
  type        = string
  description = "Instance Type for Image"
  default     = "t2.small"
}

variable "height" {
  default     = "500"
  description = "Image height in pixels."
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "placeholder" {
  default     = "placebear.com"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}
