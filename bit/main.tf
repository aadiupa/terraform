module "first" {
  source = "./modules"
  ami = "ami-011c99152163a87ae"
  instance_type = "t2.micro"
}   

output "name" {
  
  value = module.first.firsting
}