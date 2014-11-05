EmailConfig = YAML.load_file(Rails.root.join('config/email_config.yml'))[Rails.env]

ActionMailer::Base.smtp_settings = {
 :address               => EmailConfig['address'],
 :domain                => EmailConfig['domain'],
 :port                  => 25,
 :authentication        => 'plain',
 :openssl_verify_mode  => 'none',
 :enable_starttls_auto  => false,
 :user_name             => EmailConfig['user_name'],
 :password              => EmailConfig['password']
}
