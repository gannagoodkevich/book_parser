class Book < ApplicationRecord
  paginates_per 24

  belongs_to :genre,  optional: true
  belongs_to :status, optional: true
  belongs_to :cover, optional: true
end
