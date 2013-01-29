class Spree::ShipmentMailer < ActionMailer::Base
  helper "spree/base"

  def shipped_email(shipment, resend=false)
    @shipment = shipment
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Shipment Notification ##{shipment.order.number}"
    mail_params = {:to => shipment.order.email, :subject => subject}
    if shipment.order.store && shipment.order.store.email.present?
      mail_params[:from] = shipment.order.store.email
    end
    mail(mail_params)
  end
end
