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
  belongs_to(:creator, { :required => false, :class_name => "User", :foreign_key => "creator_id" })
  has_many(:attendances, { :class_name => "Attendance", :foreign_key => "plan_id", :dependent => :destroy })
  validates(:title, { :presence => true })
  validates(:title, { :uniqueness => true })
  validates(:time, { :presence => true })
  validates(:location, { :presence => true })

  def find_status
    matching_attendances = self.attendances
  
    # loop that finds if all people invited have responded to the plan yet, if all have responded returns true, if not returns false
    all_responses = true
    matching_attendances.each do |a_attendance|
      if a_attendance.pending == true 
        all_responses = false 
      end
    end

    #finds the number of people that have flaked on this plan 
    num_flakes = 0
    if all_responses == false
      return "Not everyone has responded yet!"
    end
    
    #finds the number of people that have responded to this plan
    if all_responses == true
      matching_attendances.each do |a_attendance|
        if a_attendance.flake == true 
          num_flakes = num_flakes + 1
        end
      end
    end

    # if everyone invited to the plan has flaked 
    if num_flakes == matching_attendances.size
      return "This plan has been flaked on by everyone"
    end

    #if everyone has responded to the plan but not everyone has flaked, the plan is still on
    if num_flakes < matching_attendances.size & all_responses == true 
      return "It's on!"
    end
  end
end