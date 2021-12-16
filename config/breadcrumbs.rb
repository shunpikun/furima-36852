crumb :root do
  link "Home", root_path
end

crumb :items do
  link "出品ページ", new_item_path
  parent :root
end

crumb :show do
  link "商品詳細ページ", items_path(item.id)
  parent :root
end

crumb :edit do
  link "商品編集ページ", edit_item_path
  parent :items
end

crumb :cards do
  link "クレジットカード情報登録画面", new_card_path
  parent :root
end

crumb :users do
  link "新規ユーザー登録画面", new_user_path
  parent :root
end

crumb :users do
  link "ログイン画面", new_user_registration_path
  parent :root
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).