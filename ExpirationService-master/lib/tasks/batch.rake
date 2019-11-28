namespace :batch do
  desc "Send mail to admin"
  task send_messages: :environment do
    # ExpirationMailer.expiration_mail().deliver
    command "echo 'you can use raw cron syntax too'"
  end

end