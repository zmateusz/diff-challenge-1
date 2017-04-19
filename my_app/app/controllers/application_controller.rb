class ApplicationController < ActionController::API
  def with_authorization(&block)
    token = request.headers['X-Access-Token']
    user = User.find_by(access_token: token)
    if user
      yield(user)
    else
      head :unauthorized
    end
  end
end
