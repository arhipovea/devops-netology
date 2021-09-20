# Проигнорирует:
  
\*\*/.terraform/\*
все файлы в папке .terraform. Папка может находиться в любой папке относительно корня проекта 
  
\*.tfstate  
все файлы заканчивающиеся на  .tfstate  
\*.tfstate.\*  
все файлы, у которых в серидине имени есть .tfstate.  
  
crash.log  
файл с именем crash.log  
  
\*.tfvars  
все файлы заканчивающиеся на  .tfvars  
  
override.tf  
override.tf.json  
файлы с именем override.tf и override.tf.json  
  
\*\_override.tf  
\*\_override.tf.json  
файлы заканчивающиеся на _override.tf и _override.tf.json  
  
\# !example\_override.tf  
если раскомментировать, то удалит все файлы заканчивающиеся на _override.tf, кроме файла example_override.tf  
  
\# example: \*tfplan\*  
если раскомментировать, то удалит все файлы, в имени которых встречается tfplan  
  
.terraformrc  
terraform.rc  
все фалйлы с именами .terraformrc и terraform.rc  
