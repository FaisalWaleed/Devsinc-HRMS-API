class SendMailOnUserCreationJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.send_reset_password_instructions
  end
end
