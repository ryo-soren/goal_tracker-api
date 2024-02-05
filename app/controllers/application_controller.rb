class ApplicationController < ActionController::API
    include ActionController::Cookies
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from StandardError, with: :standard_error

    def not_found
        render json: {message: "No route matches"}, status: 404
    end

    private

    def current_user
        User.find_by(id: session[:user_id])
    end

    def authenticate_user!
        unless current_user.present?
            render json: {status: 401, message: "Please sign in"}, status: 401
        end
    end

    def record_not_found(error)
        render json: "#{error.message}", status: 404
    end

    def record_invalid(error)
        invalid_record = error.record
        errors = invalid_record.errors.map do |error_object|
            {
                type: invalid_record.class.to_s,
                field: error_object.attribute,
                message: error_object.message
            }
        end
        render json: errors, status:422
    end

    def standard_error(error)
        if error.is_a?(ActiveRecord::RecordInvalid)
            record_invalid(error)
        else
            logger.error error.full_message
            errors = {
                type: error.class.to_s,
                message: error.message
            }
            render json: errors, status: 500
        end
    end
end
