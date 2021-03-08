# == Schema Information
#
# Table name: attendances
#
#  id         :integer          not null, primary key
#  attending  :boolean
#  flake      :boolean
#  pending    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :integer
#  user_id    :integer
#
class Attendance < ApplicationRecord
end
