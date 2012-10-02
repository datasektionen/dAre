Airbrake.configure do |config|
  config.api_key     = '93b98b59878955529de2a0e9f00defdf'
  config.host        = 'errbit.datasektionen.se'
  config.port        = 80
  config.secure      = config.port == 443
end
