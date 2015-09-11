class User < ActiveRecord::Base 
	has_many :posts, dependent: :destroy
	has_one :profile, dependent: :destroy
end


class Profile < ActiveRecord::Base 
	belongs_to :user
end

class Post < ActiveRecord::Base 
	belongs_to :user	
end