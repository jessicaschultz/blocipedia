class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :set_description
  before_action :authenticate_user!

  def new
  end

  def create
    customer = Stripe::Customer.create(
                  email: params[:stripeEmail],
                  source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
                  customer: customer.id,
                  amount: @amount,
                  currency: 'usd',
                  description: @description
    )

    current_user.update_attribute(:role, 1)

    flash[:notice] = "Payment Approved."

    redirect_to thanks_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  private

      def set_description
        @description = "Premium Membership"
      end

      def amount_to_be_charged
        @amount = 1500
      end

end
