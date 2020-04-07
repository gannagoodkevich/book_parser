class Book < ApplicationRecord
  paginates_per 24

  belongs_to :genre
  belongs_to :status, optional: true
  belongs_to :cover, optional: true
end
