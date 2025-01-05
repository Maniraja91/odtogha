aws_region   = "ap-south-1"                # Replace with your desired AWS region
key_name     = "odgha"                    # Replace with your key pair name
public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcmNrSmn0bD1feX5Bc3ul6/j8Ql6xJjvwF38u+zx5WbEW6yJlG7qA5ZLw/XO6EO5+NWolAbaei9SFnfORw8+eqycFP/KGeB9tPbaKuv6QHncEWSpxOyFpmE9/3iPFE643ctUvKICswgUenj25pXn2l59wP7f3oj2ymJX6SUOAekn+HyR8ZJZOkvRsodybgTtVarFH6aLnrunLzQRX3aGPqpfL9wPehV7TFOowph691JvGpZgSdOySR9k+DqirTbPvumEeRiSh7Y3Mq2yRAKmSybx7Wmn3kNOsBPXFh9nIYRjixVetpSOXW8m2MyYVuxBfua9j4iyso0mnnDhreGFuF" # Replace with your generated public key
ami_id       = "ami-03235cc8fe4d9bf1e"    # Replace with your desired AMI ID
instance_type = "t3.large"               # Optional; override the default if needed
volume_size  = 100                        # Optional; override the default if needed