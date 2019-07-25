class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrolled_in_current_course

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_enrolled_in_current_course
    unless current_user.enrolled_in?(current_lesson.section.course)
      #render plain: "Unauthorized", status: :unauthorized
      redirect_to courses_path, alert: "You must be enrolled in a course to view the lessons."
    end
  end
end
