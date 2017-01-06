class Comment < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :book
  belongs_to :user_id
end
