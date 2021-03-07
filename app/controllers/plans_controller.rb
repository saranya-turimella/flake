class PlansController < ApplicationController
  def index

    # finds all the plans that the current user has created
    my_plans = Plan.where(:creator_id => @current_user.id)
    @list_of_my_plans = my_plans.order({ :created_at => :desc })

    
    matching_plans = Plan.all 
    @list_of_plans = matching_plans.order({:created_at => :desc})

    #finds all the plans that are not created by the current user - need to fix so that it only sends the plans that the current user is invited to 
    @list_of_invited_plans = Array.new
    @list_of_plans.each do |a_plan|
      if a_plan.creator_id != @current_user.id
        @list_of_invited_plans.push(a_plan)
      end
    end

    render({ :template => "plans/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_plans = Plan.where({ :id => the_id })

    @the_plan = matching_plans.at(0)

    render({ :template => "plans/show.html.erb" })
  end

  def create
    the_plan = Plan.new
    the_plan.title = params.fetch("query_title")
    the_plan.creator_id = params.fetch("query_creator_id")
    the_plan.location = params.fetch("query_location")
    the_plan.time = params.fetch("query_time")
    the_plan.status = params.fetch("query_status")

    if the_plan.valid?
      the_plan.save
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
    the_plan.status = params.fetch("query_status")

    if the_plan.valid?
      the_plan.save
      redirect_to("/plans/#{the_plan.id}", { :notice => "Plan updated successfully."} )
    else
      redirect_to("/plans/#{the_plan.id}", { :alert => "Plan failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plan = Plan.where({ :id => the_id }).at(0)

    the_plan.destroy

    redirect_to("/plans", { :notice => "Plan deleted successfully."} )
  end
end
