json.user do |user|
  json.partial! 'user/user', user: @user
end