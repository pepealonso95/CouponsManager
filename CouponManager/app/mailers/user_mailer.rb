# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'arquisoftpract19@gmail.com'

  def non_admin_registration(user)
    @user = user
    organization = Organization.find(user.organization_id)
    mail(to: @user.email, subject: "Welcome to organization #{organization.name}")
  end
  end
