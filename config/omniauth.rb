Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_ID'], ENV['API_SECRET'],
	   :scope => 'email,read_stream', 
           :display => 'popup'
end