# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run DAre::Application

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, :host => "login.kth.se", :ssl => true
end