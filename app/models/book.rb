# require 'elasticsearch/model'

class Book < ActiveRecord::Base
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  searchkick
  Book.reindex
  has_many :chapters
  belongs_to :user
  accepts_nested_attributes_for :chapters, reject_if: :all_blank, allow_destroy: true
  validates :title, :user_id, presence: true # add user_id later on

  scope :recent,    ->{ order("created_at DESC") }
  scope :completed, ->{ where(complete: true) }
  scope :short,     ->{ where("volumes <= 4") }
end
