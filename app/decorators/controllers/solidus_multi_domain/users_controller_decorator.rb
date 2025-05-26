# frozen_string_literal: true

module SolidusMultiDomain
  module UsersControllerDecorator
    def show
      load_object
      @orders = @user.orders.complete.by_store(current_store).order("completed_at desc")
    end

    if const_defined?("::UsersController")
      ::UsersController.prepend(self)
    end
  end
end
