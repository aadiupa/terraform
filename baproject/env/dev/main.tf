module "account" {
   count = var.service=="account" ? 1 : 0
   source = "../../modules/account"
}

module "alignx" {
   count = var.service=="alignx" ? 1 : 0
   source = "../../modules/alignx"
}