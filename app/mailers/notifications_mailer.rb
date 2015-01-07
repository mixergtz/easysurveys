class NotificationsMailer < ActionMailer::Base
  default from: "notifications@easysurveys.com"

  def new_survey_response_email(survey)
    @survey = survey
    mail(to: @survey.user.email, subject: "A new response for your survey")
  end
end
