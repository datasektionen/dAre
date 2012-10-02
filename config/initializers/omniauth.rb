Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, :host => "login.kth.se", :ssl => true
end