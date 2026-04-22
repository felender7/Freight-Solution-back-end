class Admin::Warehouse::PalletsController < Admin::BaseController
  def index
    @pallets = Pallet.includes(:client, :warehouse_location).all
  end
end
