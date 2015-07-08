class FacebookNetwork < ActiveRecord::Base
  belongs_to :user


  def self.create_to_user(user, profile, access_token)
    facebook = FacebookNetwork.new(facebook_id: profile["id"], access_token: access_token)
    facebook.user = user
    facebook.save!
  end


  def self.permissions
    ["email"]
  end
end
