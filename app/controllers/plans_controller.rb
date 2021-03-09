class PlansController < ApplicationController
  def index
    # finds all the plans that the current user has created
    my_plans = Plan.where(:creator_id => @current_user.id)
    @list_of_my_plans = my_plans.order({ :created_at => :desc })

    # finds all the plans that the current user has not created
    list_of_not_created_plans = Array.new
    matching_plans = Plan.all 
    list_of_plans = matching_plans.order({:created_at => :desc})
    list_of_plans.each do |a_plan|
      if a_plan.creator_id != @current_user.id
        list_of_not_created_plans.push(a_plan)
      end
    end

    # finds all the plans that the current user is invited to... goes through the list of plans that the current user has not created
    # finds the matching attendances for each plan that the current user has not craeated 
    # if there is an attendance with a user id that is equal to the current user id then that is plan that the current user is invited to
    @list_of_invited_plans = Array.new
    list_of_not_created_plans.each do |a_plan|
      matching_attendances = Attendance.where(:plan_id => a_plan.id)
        matching_attendances.each do |a_attendance|
          if a_attendance.user_id == @current_user.id
            matching_plan = Plan.where(:id => a_attendance.plan_id).first
            @list_of_invited_plans.push(matching_plan)
          end
        end
      end

    render({ :template => "plans/index.html.erb" })
  end

  def show_my_plans
    the_id = params.fetch("path_id")

    matching_plans = Plan.where({ :id => the_id })

    @the_plan = matching_plans.at(0)

    render({ :template => "plans/show_my_plans.html.erb" })
  end

  def show_my_invited_plans
    the_id = params.fetch("path_id")

    matching_plans = Plan.where({ :id => the_id })

    @the_plan = matching_plans.at(0)

    render({ :template => "plans/show_my_invited_plans.html.erb" })
  end

  def create
    the_plan = Plan.new
    the_plan.title = params.fetch("query_title")
    the_plan.creator_id = params.fetch("query_creator_id")
    the_plan.location = params.fetch("query_location")
    the_plan.time = params.fetch("query_time")
    the_plan.status = "Not everyone has responded yet"
    @invited_id = params.fetch("query_invited_id")

    if the_plan.valid?
      the_plan.save
      invited_attendance = Attendance.new
      invited_attendance.user_id = @invited_id
      invited_attendance.plan_id = the_plan.id
      invited_attendance.flake = false
      invited_attendance.pending = true 
      invited_attendance.attending = true
      invited_attendance.save 
      redirect_to("/plans", { :notice => "Plan created successfully." })
    else
      redirect_to("/plans", { :notice => "Plan failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plan = Plan.where({ :id => the_id }).at(0)

    the_plan.title = params.fetch("query_title")
    the_plan.creator_id = params.fetch("query_creator_id")
    the_plan.location = params.fetch("query_location")
    the_plan.time = params.fetch("query_time")
    the_plan.status = "Not everyone has responded yet!"

    if the_plan.valid?
      the_plan.save
      redirect_to("/my_plans/#{the_plan.id}", { :notice => "Plan updated successfully."} )
    else
      redirect_to("/my_plans/#{the_plan.id}", { :alert => "Plan failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plan = Plan.where({ :id => the_id }).at(0)

    the_plan.destroy

    redirect_to("/plans", { :notice => "Plan deleted successfully."} )
  end
end
