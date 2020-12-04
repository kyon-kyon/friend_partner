class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true, length: { in: 2..20 }
  validates :first_name, presence: true, length: { in: 2..20 }
  validates :kana_last_name, presence: true, length: { in: 2..20 }
  validates :kana_first_name, presence: true, length: { in: 2..20 }
  validates :introduction, presence: true, length: { in: 2..1000 }
  # validates :profile_image_id, presence:true
  validates :for_what_application, presence: true, length: { in: 2..1000 }
  validates :message_level, presence: true, length: { in: 2..1000 }
  validates :ignore_character, presence: true, length: { in: 2..1000 }
  validates :occupation, presence: true, length: { in: 2..50 }
  validates :think_to_job, presence: true, length: { in: 2..1000 }
  validates :want_job_time, presence: true, length: { in: 2..50 }
  validates :think_job_relationship, presence: true, length: { in: 2..1000 }
  validates :can_offer_job, presence: true, length: { in: 2..1000 }
  validates :target_income, presence: true, length: { in: 2..1000 }
  validates :what_want_learn, presence: true, length: { in: 2..1000 }
  validates :like_other_job, presence: true, length: { in: 2..1000 }
  validates :what_desire_love, presence: true, length: { in: 2..1000 }
  validates :how_did_life, presence: true, length: { in: 2..1000 }
  validates :past_failures, presence: true, length: { in: 2..1000 }
  validates :basic_experience, presence: true, length: { in: 2..1000 }
  validates :what_require, presence: true, length: { in: 2..1000 }
  validates :my_personality, presence: true, length: { in: 2..1000 }
  validates :can_offer_personality, presence: true, length: { in: 2..1000 }
  validates :request_relationship_spirit, presence: true, length: { in: 2..1000 }
  validates :interested_by_given, presence: true, length: { in: 2..1000 }

  has_many :post_comments, dependent: :destroy
  has_many :soliloquies, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :active_relationships,  class_name: "Relationship",
                                   foreign_key: "follower_id",
                                   dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attachment :profile_image

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end


  def kana_name
    kana_last_name + kana_first_name
  end

  def self.guest
    find_or_create_by!(

      last_name: 'ゲスト田中',
      first_name: 'ゲストたかし',
      kana_last_name: 'ゲストタナカ',
      kana_first_name: 'ゲストタカシ',
      introduction: 'ゲストログインです',
      for_what_application: 'ゲストログインです',
      message_level: 'ゲストログインです',
      ignore_character: 'ゲストログインです',
      occupation: 'ゲストログインです',
      think_to_job: 'ゲストログインです',
      want_job_time: 'ゲストログインです',
      think_job_relationship: 'ゲストログインです',
      can_offer_job: 'ゲストログインです',
      target_income: 'ゲストログインです',
      what_want_learn: 'ゲストログインです',
      like_other_job: 'ゲストログインです',
      what_desire_love: 'ゲストログインです',
      how_did_life: 'ゲストログインです',
      past_failures: 'ゲストログインです',
      basic_experience: 'ゲストログインです',
      what_require: 'ゲストログインです',
      my_personality: 'ゲストログインです',
      can_offer_personality: 'ゲストログインです',
      request_relationship_spirit: 'ゲストログインです',
      interested_by_given: 'ゲストログインです',
      # is_deleted: 'Availble',

      email: 'guest@example.com'

    ) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def name
    last_name + first_name
  end

  # Availble:稼働中 Invaild:退会済み
  enum is_deleted: { Availble: false, Invaild: true }

  def active_for_authentication?
    super && (is_deleted == "Availble")
  end
end
