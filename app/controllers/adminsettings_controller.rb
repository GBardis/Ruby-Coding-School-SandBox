# Documentation # TODO: Documentation
class AdminsettingsController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @setting = Adminsetting.first
    @available_columns = []
    search_response = Search.search(query: { match_all: {} }, size: 1)
    search_response.first.attributes.each do |name, _value|
      @available_columns << name
    end
  end

  def update
    @setting = Adminsetting.first
    if @setting.update_attribute(:preferences, params['adminsetting']['preferences'])
      flash[:success] = 'Updated Successfully'
      redirect_to root_path
    end
  end

  private

  def adminsetting_params
    params.require(:adminsetting).permit(preferences: [])
  end
end
