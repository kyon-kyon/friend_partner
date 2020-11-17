# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :last_name
      t.string :first_name
      t.string :kana_last_name
      t.string :kana_first_name
      t.text :introduction
      t.string :profile_image_id
      t.text :for_what_application
      t.text :message_level
      t.text :ignore_character
      t.string :occupation
      t.text :think_to_job
      t.text :want_job_time
      t.text :think_job_relationship
      t.text :can_offer_job
      t.string :target_income
      t.text :what_want_learn
      t.text :like_other_job
      t.text :what_desire_love
      t.text :how_did_life
      t.text :past_failures
      t.text :basic_experience
      t.text :what_require
      t.text :my_personality
      t.text :can_offer_personality
      t.text :request_relationship_spirit
      t.text :interested_by_given
      t.boolean :is_deleted, nill: false, default: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
