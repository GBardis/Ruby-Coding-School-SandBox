class AdminsettingsController < ApplicationController
  def edit
    @setting = Adminsetting.find(params[:id])
    @hash = Hashie::Mash.new @setting.preferences
  end

  def update
    @setting = Adminsetting.find(params[:id])
    if @setting.update_attributes(adminsetting_params)
      flash[:success] = 'Updated Successfully'
      redirect_to root_path
    end
  end
  private

  def adminsetting_params
    params.require(:adminsetting).permit(preferences:{})
  end
end
