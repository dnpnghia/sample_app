class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email,
    subject: t("users.activation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("users.reset_pass")
  end
end
