class Book < ActiveRecord::Base
  has_many :chapters
  accepts_nested_attributes_for :chapters, reject_if: :all_blank, allow_destroy: true
end
