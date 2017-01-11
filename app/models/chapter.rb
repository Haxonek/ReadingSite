class Chapter < ActiveRecord::Base
  belongs_to :album # add " counter_cache: true"?? for scope
  belongs_to :user
  has_many :comments
  validates :title, :tags, :content, presence: true
end
