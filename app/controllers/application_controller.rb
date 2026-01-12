class ApplicationController < ActionController::API
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
	rescue_from ActionController::ParameterMissing, with: :render_bad_request
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

	private

	def render_not_found(error)
		render json: { error: error.message || 'not found' }, status: :not_found
	end

	def render_bad_request(error)
		render json: { error: error.message || 'bad request' }, status: :bad_request
	end

	def render_unprocessable_entity(error)
		record = error.respond_to?(:record) ? error.record : nil
		messages = record ? record.errors.full_messages : [error.message]
		render json: { errors: messages }, status: :unprocessable_entity
	end
end
