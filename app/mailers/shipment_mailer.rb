class ShipmentMailer < ActionMailer::Base
  helper "spree/base"

  def shipped_email(shipment, resend=false)
    @shipment = shipment
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Shipment Notification ##{shipment.order.number}"
    mail_params = {:to => shipment.order.email, :subject => subject}
    mail_params[:from] = shipment.order.store.email if shipment.order.store.email.present?
    mail(mail_params)
  end
end
