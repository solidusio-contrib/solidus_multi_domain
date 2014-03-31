module Spree
  class ShipmentMailer < BaseMailer
    def shipped_email(shipment, resend = false)
      @shipment = shipment.respond_to?(:id) ? shipment : Spree::Shipment.find(shipment)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Config[:site_name]} #{Spree.t('shipment_mailer.shipped_email.subject')} ##{@shipment.order.number}"

      mail_params = {:to => @shipment.order.email, :subject => subject}
      if @shipment.order.store && @shipment.order.store.mail_from_address.present?
        mail_params[:from] = @shipment.order.store.mail_from_address
      else
        mail_params[:from] = Spree::Store.default.mail_from_address
      end
      mail(mail_params)
    end
  end
end
