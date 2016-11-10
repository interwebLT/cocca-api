class UpdatingDeletedDomain < ApplicationMailer
  def send_notice domain, partner, email
    @domain_name  = domain
    @partner_name = partner
    mail to: email, subject: "Deleted Domain Trying to update notice."
  end
end
