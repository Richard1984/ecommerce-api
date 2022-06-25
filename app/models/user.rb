class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  def self.find_or_create_with_facebook_access_token(oauth_access_token)
    @graph = Koala::Facebook::API.new(oauth_access_token)
    profile = @graph.get_object('me', fields: ['first_name', 'last_name', 'picture', 'email'])

    data = {
      # name: profile['name'],
      email: profile['email'],
      uid: profile['id'],
      provider: 'facebook',
      # oauth_token: oauth_access_token,
      # image: "https://graph.facebook.com/#{profile['id']}/picture?type=large",
      password: SecureRandom.urlsafe_base64
    }

    user = User.find_by(uid: data[:uid], provider: 'facebook')
    token = user.generate_jwt

    if user
      user.update(data)
    else
      User.create(data)
    end

    { 'user' => user, 'token' => token }
  end

  def generate_jwt
    JWT.encode({ id: id,
              exp: 60.days.from_now.to_i },
             Rails.application.secrets.secret_key_base)
  end
end
