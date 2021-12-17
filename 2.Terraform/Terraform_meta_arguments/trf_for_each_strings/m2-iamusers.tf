resource "aws_iam_user" "myuser" {
  for_each = toset(["Aarthi", "Janardhan", "Madhu", "Daniel"])
  name     = each.key

}