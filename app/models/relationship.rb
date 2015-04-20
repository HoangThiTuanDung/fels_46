class Relationship < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller && controller.current_user}
  tracked recipient: ->(controller, model) {model && model.followed}

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end