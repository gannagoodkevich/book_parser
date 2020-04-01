class Book < ApplicationRecord
  has_one :genre
  has_one :status
  has_one :cover
end
