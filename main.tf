module "db_authors_table" {
  source = "./modules/dynamodb"

  name    = "authors"
  context = module.label.context

}

module "db_courses_table" {
  source = "./modules/dynamodb"

  name    = "courses"
  context = module.label.context
}

module "lambda" {
  source                  = "./modules/lambda"
  context                 = module.label.context
  name                    = "authors"
  name_courses            = "courses"
  name_courses_save       = "course-save"
  name_courses_get        = "course-get"
  name_courses_delete     = "course-delete"
  name_courses_update     = "course-update"
  table_authors_name       = module.db_authors_table.table_name
  table_authors_arn        = module.db_authors_table.table_arn
  table_courses_name      = module.db_courses_table.table_name
  table_courses_arn       = module.db_courses_table.table_arn
  lambda_courses_role_arn = module.iam.table_courses_role_arn
  lambda_authors_role_arn = module.iam.table_authors_role_arn

}

resource "aws_iam_user" "the-accounts" {
  for_each = toset(["Todd", "James", "Alice", "Dottie"])
  name     = "${module.label.id}-${each.key}"
}

module "iam" {
  source            = "./modules/iam"
  context           = module.label.context
  name              = "iam"
  table_authors_arn  = module.db_authors_table.table_arn
  table_courses_arn = module.db_courses_table.table_arn
}