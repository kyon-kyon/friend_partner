class Soliloquy < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length: { in: 2..30 }
  validates :object, presence: true, length: { in: 2..1000 }
  validates :what_do, presence: true, length: { in: 2..1000 }
  validates :how_feel, presence: true, length: { in: 2..1000 }
  validates :must_and_can, presence: true, length: { in: 2..1000 }
  validates :did_action, presence: true, length: { in: 2..1000 }
  validates :purpose_soliloquy, presence: true, length: { in: 2..1000 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
