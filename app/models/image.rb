class Image < ApplicationRecord

  belongs_to :user

  attr_accessor :image

end
