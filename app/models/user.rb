# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init
  has_many :wikis

  def init
    self.role ||= "standard"
  end

  def admin?
    self.role == "admin"
  end

  def premium?
    self.role == "premium"
  end

  def upgrade_account(user)
    user.role = "premium"
    user.save
  end

  def downgrade_account(user)
    user.role = "standard"
    downgrade_private_wikis(user)
    user.save
  end

  def downgrade_private_wikis(user)
    wikis = Wiki.where(user: user, private: true)
    wikis.each do |wiki|
      wiki.private = false
    end
  end
end
