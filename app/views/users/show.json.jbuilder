json.user do
  json.id                       @user.id
  json.api_token                @user.api_token
  json.email                    @user.email
  json.role                     @user.role
end
