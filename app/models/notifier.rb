class Notifier < ActionMailer::Base

  default_url_options[:host] = SITE_HOST

  def password_reset_instructions(user)
    subject I18n.t('app.password_resets.email_subject')
    from EMAIL_FROM
    recipients user.email
    sent_on Time.now
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
    content_type  "text/html"
  end
end

