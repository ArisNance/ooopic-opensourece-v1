class User < ActiveRecord::Base
 
    has_many :likes
    has_many :photos

    def likes?(photo)
      photo.likes.where(user_id: id).any?
    end

 
    def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
    end
    
    def to_param
     "#{id} #{name}".parameterize
    end
    
 
  ## Will include edit email section for facebook users and will use devise and gravatar for users without facebook
   def avatar_url
     hash = Digest::MD5.hexdigest(email)
     "http://www.gravatar.com/avatar/#{hash}"
   end
end
