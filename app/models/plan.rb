# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  location   :string
#  status     :string
#  time       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#
class Plan < ApplicationRecord
end
