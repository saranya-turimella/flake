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
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:plan, { :required => false, :class_name => "Plan", :foreign_key => "plan_id" })
  validates(:user_id, { :presence => true })
  validates(:user_id, { :uniqueness => { :scope => ["plan_id"] } })
  validates(:plan_id, { :presence => true })

  def get_status_text
    if self.attending == true && self.pending == false
      return "You are attending this plan"
    end
    if self.attending == false && self.pending == false 
      return "You are not attending this plan"
    end
  end
end
