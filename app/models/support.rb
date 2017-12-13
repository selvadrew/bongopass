class Support < MailForm::Base
  attribute :full_name
  attribute :email,             :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :feedback,          :validate => true
  attribute :nickname,          :captcha  => true
  attribute :user 


  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Feedback",
      :to => "andrew@bongopass.com",
      :from => %(<#{email}>)
    }
  end
end