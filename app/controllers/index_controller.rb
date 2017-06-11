class IndexController < ApplicationController

  def search
    @table = 'datatables_demo'
    @primaryKey = 'id'

    @columns = ''

  end

end


