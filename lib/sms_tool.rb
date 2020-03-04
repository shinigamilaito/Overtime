module SmsTool
  account_sid = Rails.application.secrets[:TWILIO_ACCOUNT_SID]
  auth_token = Rails.application.secrets[:TWILIO_AUTH_TOKEN]

  @client = Twilio::REST::Client.new account_sid, auth_token

  def self.send_sms(number:, message:)
    @client.messages.create(
      from: Rails.application.secrets[:TWILIO_PHONE_NUMBER],
      to: "+52#{number}",
      body: "#{message}"
    )
  end
end