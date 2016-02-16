class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_enrollment_to_view_lessons, only: [:show]

	def show
	end

	private

	def require_enrollment_to_view_lessons
		this_course = current_lesson.section.course

		if !current_user.enrolled_in?(this_course)
			redirect_to course_path(this_course), alert: 'You must be enrolled in the course to view the lessons'
		end
	end


	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end
end
