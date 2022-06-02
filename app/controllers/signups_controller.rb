class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  #POST /signups
  def create 
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created  #returns the associated activity, based on the activity serializer criteria
  end

  private
  def signup_params
    params.permit(:time, :camper_id, :activity_id)  
  end
  
  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
