class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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


  #ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  #フォローしあったらマッチング
  def matchers
  following & followers
  end


  def kana_name
    kana_last_name + kana_first_name
  end

  def self.guest
    find_or_create_by!(

    # profile_image: "no_image.jpg",
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

#Availble:稼働中 Invaild:退会済み
  enum is_deleted: {Availble: false, Invaild: true}

  def active_for_authentication?
    super && (self.is_deleted == "Availble")
  end


end
