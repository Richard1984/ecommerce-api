json.(user, :id, :email, :image)
json.token user.generate_jwt