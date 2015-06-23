module Spree
  class OrderMailer < BaseMailer
    def confirm_email(order, resend = false)
      find_order(order)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.default.name} #{Spree.t('order_mailer.confirm_email.subject')} ##{@order.number}"
      mail_params = {:to => @order.email, :subject => subject}
      if @order.store.present? && @order.store.mail_from_address.present?
        mail_params[:from] = @order.store.mail_from_address
      else
        mail_params[:from] = Spree::Store.default.mail_from_address
      end
      mail(mail_params)
    end

    def cancel_email(order, resend = false)
      find_order(order)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.default.name} #{Spree.t('order_mailer.cancel_email.subject')} ##{@order.number}"
      mail_params = {:to => @order.email, :subject => subject}
      if @order.store.present? && @order.store.mail_from_address.present?
        mail_params[:from] = @order.store.mail_from_address
      else
        mail_params[:from] = Spree::Store.default.mail_from_address
      end
      mail(mail_params)
    end

    def inventory_cancellation_email(order, inventory_units, resend = false)
      @order, @inventory_units = find_order(order), inventory_units
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.default.name} #{Spree.t('order_mailer.inventory_cancellation.subject')} ##{@order.number}"
      mail_params = {:to => @order.email, :subject => subject}
      if @order.store.present? && @order.store.mail_from_address.present?
        mail_params[:from] = @order.store.mail_from_address
      else
        mail_params[:from] = Spree::Store.default.mail_from_address
      end

      mail(to: @order.email, from: from_address, subject: subject)
    end

    private

    def find_order(order)
      @order = order.is_a?(Spree::Order) ? order : Spree::Order.find(order)
    end
  end
end
