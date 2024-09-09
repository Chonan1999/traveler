class Post < ApplicationRecord

    attachment :image
    belongs_to :user
    has_many :comment, dependent: :destroy
end
