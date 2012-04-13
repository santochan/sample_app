class Micropost < ActiveRecord::Base
  attr_accessible :content

  
  belongs_to :user
  
  default_scope order: 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user)  }
  
  validates :user_id,  :presence => true
  validates :content,  :presence => true, :length => { maximum: 140 }
  

  
  private
    
    def self.followed_by(user)
      followed_user_ids = %(SELECT followed_id from relationships
                            WHERE follower_id= :user_id)
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id ",
            { user_id: user })
    end
  
end
