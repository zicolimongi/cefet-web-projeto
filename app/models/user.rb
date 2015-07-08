class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :facebook_network


  def self.find_or_create_with_facebook_account(profile, access_token)
    facebook = FacebookNetwork.find_by_facebook_id(profile["id"])
    # Se o usuário já estiver cadastrado com FB no sistema
    if facebook
      user = facebook.user
    # Se o usuário estiver cadastrado no sistema, mas sem FB
    elsif user = User.find_by_email(profile["email"])
      FacebookNetwork.create_to_user(user,profile,access_token)
    # Usuário que não estava cadastrado no sistema
    else
      user = create_with_facebook_account(profile,access_token)
    end
    user
  end

   def self.create_with_facebook_account(profile, access_token)
    new_user = User.new(email: profile["email"])
    new_user.password = SecureRandom.hex(3)
    new_user.save!

    FacebookNetwork.create_to_user(new_user,profile,access_token)
    new_user
  end
end
