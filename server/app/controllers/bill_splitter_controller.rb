class BillSplitterController < ApplicationController
  def new
  end

  def create
    amount = params[:amount]
    tax = params[:tax]
    tip = params[:tip]
    num_of_people = params[:num_of_people]
    @split_amount = amount.to_f * tax.to_f * tip.to_f / num_of_people.to_f
  end
end
