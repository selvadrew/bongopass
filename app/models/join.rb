class Join < MailForm::Base
  attribute :full_name,         :validate => true
  attribute :email,             :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :company,           :validate => true
  attribute :website,           :validate => true
  attribute :phone
  attribute :event_count,       :validate => true
  attribute :ticket_count,      :validate => true
  attribute :tell_us_more,      :validate => true
  attribute :nickname,          :captcha  => true
  attribute :user 

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "NEW APPLICATION !!!!",
      :to => "andrew@bongopass.com",
      :from => %("#{full_name}" <#{email}>)
    }
  end
end