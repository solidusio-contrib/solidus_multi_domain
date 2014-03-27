class Spree::OrderMailer < ActionMailer::Base
  helper "spree/base"

  def confirm_email(order, resend=false)
    find_order(order)
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Order Confirmation ##{@order.number}"
    mail_params = {:to => @order.email, :subject => subject}
    mail_params[:from] = @order.store.email if @order.store.present? && @order.store.email.present?
    mail(mail_params)
  end

  def cancel_email(order, resend=false)
    find_order(order)
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Cancellation of Order ##{@order.number}"
    mail_params = {:to => @order.email, :subject => subject}
    mail_params[:from] = @order.store.email if @order.store.present? &&  @order.store.email.present?
    mail(mail_params)
  end

  private
    def find_order(order)
      @order = order.is_a?(Spree::Order) ? order : Spree::Order.find(order)
    end
end
