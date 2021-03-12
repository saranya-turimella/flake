class AttendancesController < ApplicationController
  def index
    matching_attendances = Attendance.all

    @list_of_attendances = matching_attendances.order({ :created_at => :desc })

    render({ :template => "attendances/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_attendances = Attendance.where({ :id => the_id })

    @the_attendance = matching_attendances.at(0)

    render({ :template => "attendances/show.html.erb" })
  end

  def create
    the_attendance = Attendance.new
    the_attendance.user_id = params.fetch("query_user_id")
    the_attendance.plan_id = params.fetch("query_plan_id")
    the_attendance.flake = params.fetch("query_flake", false)
    the_attendance.pending = params.fetch("query_pending", true)
    the_attendance.attending = params.fetch("query_attending", false)

    if the_attendance.valid?
      the_attendance.save
      redirect_to("/attendances", { :notice => "Attendance created successfully." })
    else
      redirect_to("/attendances", { :notice => "Attendance failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_attendance = Attendance.where({ :id => the_id }).at(0)

    the_attendance.user_id = params.fetch("query_user_id")
    the_attendance.plan_id = params.fetch("query_plan_id")
    the_attendance.flake = params.fetch("query_flake", false)
    the_attendance.pending = params.fetch("query_pending", false)
    the_attendance.attending = params.fetch("query_attending", false)

    if the_attendance.valid?
      the_attendance.save
      redirect_to("/attendances/#{the_attendance.id}", { :notice => "Attendance updated successfully."} )
    else
      redirect_to("/attendances/#{the_attendance.id}", { :alert => "Attendance failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_attendance = Attendance.where({ :id => the_id }).at(0)

    the_attendance.destroy

    redirect_to("/attendances", { :notice => "Attendance deleted successfully."} )
  end
end
