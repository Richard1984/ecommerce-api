class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.find_or_create_with_facebook_access_token(oauth_access_token)
    @graph = Koala::Facebook::API.new(oauth_access_token)
    profile = @graph.get_object('me', fields: ['name', 'email'])

    data = {
      name: profile['name'],
      email: profile['email'],
      uid: profile['id'],
      provider: 'facebook',
      oauth_token: oauth_access_token,
      picture_url: "https://graph.facebook.com/#{profile['id']}/picture?type=large",
      password: SecureRandom.urlsafe_base64
    }

    if user == User.find_by(uid: data['uid'], provider: 'facebook')
      user.update_attributes(data)
    else
      User.create(data)
    end
  end
end
