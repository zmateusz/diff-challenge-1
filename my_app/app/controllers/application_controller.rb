class ApplicationController < ActionController::API
  def with_authorization(&block)
    token = request.headers['X-Access-Token']
    if User.find_by(access_token: token)
      yield
    else
      head :unauthorized
    end
  end
end
