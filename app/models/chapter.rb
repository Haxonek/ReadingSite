class Chapter < ActiveRecord::Base
  belongs_to :album # add " counter_cache: true"?? for scope
  has_many :comments
  validates :title, :tags, :content, presences: true
end
