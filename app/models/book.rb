class Book < ActiveRecord::Base
  has_many :chapters
  accepts_nested_attributes_for :chapters, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true # add user_id later on

  scope :completed, ->{ where(complete: true) }
  scope :short,     ->{ where("volumes <= 4") }
end
