class InquiryMailer < ActionMailer::Base

  def notification_to_admin(inquiry)
    setup_email(Setting.first.inquiry_notification_email, CMS_CONFIG['website']['name'], inquiry.email, inquiry.name, "New inquiry received (\##{inquiry.id}) for #{CMS_CONFIG['website']['domain']}")
    body :inquiry => inquiry
  end
  
  def confirmation_to_user(inquiry)
    setup_email(inquiry.email, inquiry.name, Setting.first.inquiry_notification_email, CMS_CONFIG['website']['name'], "#{Setting.first.inquiry_confirmation_subject_line or "Inquiry"}")
    body :confirmation_message => "#{Setting.first.inquiry_confirmation_message or "Thanks for your Inquiry"}", :inquiry => inquiry
  end

  
  private
  
  def setup_email(to_email, to_name, from_email, from_name, subject)
    cms_config ||= YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    recipients   "#{to_name.strip} <#{to_email.strip}>"
    from         "#{CMS_CONFIG['website']['name']} <#{CMS_CONFIG['site_settings']['sendgrid_username']}>"
    headers      'Reply-to' => "#{from_name.strip} <#{from_email.strip}>"
    subject      subject.strip 
    sent_on      Time.now
    content_type 'text/html'
  end

end
