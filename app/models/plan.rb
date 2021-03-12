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
  # validates(:title, { :uniqueness => true })
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
    

    #if there is one person that has not responded to the plan yet, return that not everyone has responded yet
    if all_responses == false
      return "Not everyone has responded yet!"
    end
    
    #if everyone has responded to this plan, lets count the number of people that have flaked
    num_flakes = 0
    if all_responses == true
      matching_attendances.each do |a_attendance|
        if a_attendance.flake == true 
          num_flakes = num_flakes + 1
        end
      end
    end

    # if the number of people that flaked is equal to the number of people invited to this plan, then this plan has been flaked on 
    # must be equal, because everyone must want to flake in order for it to be flaked on by everyone
    if num_flakes == matching_attendances.size
      return "This plan has been flaked on by everyone"
    end

    #if there are some flakes, and everyone has responded 
    if num_flakes < matching_attendances.size && all_responses == true 
      return "It's on!"
    end
  end
end