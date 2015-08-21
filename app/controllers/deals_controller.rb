class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  def index
    @deals = current_user.deals
  end

  def new
    @deal = current_user.deals.build
  end

  def edit
  end

  def create
    @deal = current_user.deals.build(deal_params)

    if @deal.save
      redirect_to deals_path, notice: 'Deal was successfully created.'
    else
      render :new
    end
  end

  def update
    if @deal.update(deal_params)
      redirect_to deals_path, notice: 'Deal was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:fundamental, :trend_id, :profit)
  end
end
