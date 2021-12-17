crumb :root do
  link "Home", root_path
end

crumb :item_new do
  link "出品画面", new_item_path
  parent :root
end

crumb :item_show do |item|
  link "#{item.name}の詳細画面", item_path(item)
  parent :root
end

crumb :item_edit do |item|
  link "商品編集画面"
  parent :item_show, item
end

crumb :card_new do
  link "クレジットカード情報登録画面", new_card_path
  parent :root
end

crumb :user_new do
  link "ログイン画面", user_session_path
  parent :root
end

crumb :user_registration do
  link "ユーザー登録画面", user_registration_path
  parent :root
end

crumb :order_new do |item|
  link "#{item.name}の購入画面"
  parent :item_show, item
end

crumb :look_new do
  link "商品検索画面", items_look_path
  parent :root
end

crumb :user_show do |user|
  link "#{user.nickname}さんのクレジットカード詳細画面", user_path(user)
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