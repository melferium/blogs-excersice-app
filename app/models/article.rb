class Article < ApplicationRecord


  validates :title, presence: true, length: {minimum: 3, maximum: 10}
  

end