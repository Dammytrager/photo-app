# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_images_on_user_id  (user_id)
#
class Image < ApplicationRecord

  has_one_attached :image

  belongs_to :user

  attr_accessor :image

end
