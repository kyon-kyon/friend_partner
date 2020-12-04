class PostComment < ApplicationRecord
  validates :comment, presence: true, length: { in: 2..200 }

  belongs_to :user
  belongs_to :soliloquy
end
