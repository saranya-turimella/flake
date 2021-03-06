# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:attendances, { :class_name => "Attendance", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:plans, { :class_name => "Plan", :foreign_key => "creator_id", :dependent => :destroy })

  validates(:username, { :presence => true })
  validates(:username, { :uniqueness => true })
  validates(:last_name, { :presence => true })
  validates(:first_name, { :presence => true })
end
