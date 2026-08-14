class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string  :email_address,    null: false
      t.string  :password_digest
      t.integer :role,             null: false, default: 0
      t.references :organization,  foreign_key: true

      # TOTP 2FA
      t.string   :otp_secret
      t.datetime :otp_enabled_at

      # Invitation flow (single-use token, 7-day expiry)
      t.string   :invite_token
      t.datetime :invite_sent_at
      t.datetime :invite_accepted_at

      t.timestamps
    end

    add_index :users, :email_address, unique: true
    add_index :users, :invite_token,  unique: true
  end
end
