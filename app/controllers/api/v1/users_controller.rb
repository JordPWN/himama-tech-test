class Api::V1::UsersController < Api::V1::ApiController
    skip_before_action :authenticate_request
    
    wrap_parameters :user, include: [:name, :password, :email]

    def create
        user = User.new(user_params)

        if user.save
            render json: {status: 'User created successfully', user: user}, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :bad_request
        end
    end
  
    private
  
    def user_params
        params.require(:user).permit(:email, :password, :name)
    end
end