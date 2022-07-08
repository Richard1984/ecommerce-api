class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :products, :through => :reviews
  has_many :orders
  has_many :lists, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_one_attached :avatar

  def self.find_or_create_with_facebook_access_token(oauth_access_token)
    @graph = Koala::Facebook::API.new(oauth_access_token)
    profile = @graph.get_object('me', fields: ['firstname', 'lastname', 'picture', 'email'])

    data = {
      firstname: profile['first_name'],
      lastname: profile['last_name'],
      email: profile['email'],
      uid: profile['id'],
      provider: 'facebook',
      # oauth_token: oauth_access_token,
      # avatar: "https://graph.facebook.com/#{profile['id']}/picture?type=large",
      avatar: profile['picture'],
      password: SecureRandom.urlsafe_base64
    }

    user = User.find_by(uid: data[:uid], provider: 'facebook')

    if user
      user.update(data)
    else
      user = User.create(data) # error handling?
    end

    token = user.generate_jwt

    { 'user' => user, 'token' => token }
  end

  def generate_jwt
    JWT.encode({ id: id,
              exp: 60.days.from_now.to_i },
             Rails.application.secrets.secret_key_base)
  end
end
