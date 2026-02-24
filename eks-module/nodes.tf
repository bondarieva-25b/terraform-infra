# EKS-optimized AMI lookup
data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/${var.kubernetes_version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

# Launch Template
resource "aws_launch_template" "node" {
  name_prefix   = "${var.cluster_name}-node-"
  image_id      = data.aws_ssm_parameter.eks_ami.value
  instance_type = "t3.medium"

  iam_instance_profile {
    name = aws_iam_instance_profile.node.name
  }

  vpc_security_group_ids = [aws_security_group.node.id]

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    cluster_name         = var.cluster_name
    cluster_endpoint     = aws_eks_cluster.this.endpoint
    cluster_ca           = aws_eks_cluster.this.certificate_authority[0].data
    cluster_service_cidr = aws_eks_cluster.this.kubernetes_network_config[0].service_ipv4_cidr
  }))

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name                                        = "${var.cluster_name}-node"
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "node" {
  name_prefix         = "${var.cluster_name}-node-"
  min_size            = var.node_min_size
  max_size            = var.node_max_size
  desired_capacity    = var.node_desired_size
  vpc_zone_identifier = var.public_subnet_ids

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 20
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.node.id
        version            = "$Latest"
      }

      override {
        instance_type = "t3.medium"
      }

      override {
        instance_type = "t3a.medium"
      }

      override {
        instance_type = "t2.medium"
      }
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}

