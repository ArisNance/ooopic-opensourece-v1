json.photos do
  json.array!(@photos) do |photo|
    json.name photo.title
    json.url photo_path(photo)
  end
end

#json.users do
 # json.array!(@users) do |user|
  #  json.name user.name
   # json.url user_path(user)
  #end
#end