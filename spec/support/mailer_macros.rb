module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end
  # in specs
  #   last_email.to.should include(user.email)
  
  def reset_email
    ActionMailer::Base.deliveries = []
  end
end