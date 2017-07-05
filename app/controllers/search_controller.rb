require 'elasticsearch/model'
require 'elasticsearch/persistence/model'
require 'elasticsearch/dsl'

# Documentation # TODO: Documentation
class SearchController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :update, :destroy]

  def index
    if Adminsetting.count.zero?
      new_adminsetting = Adminsetting.new
      new_adminsetting.save
    end
    @skip_columns = Adminsetting.first.preferences
    @search_result = Search.search(query: {match_all: {}}, size: 1)
  end

  def show
    response = Search.search(query: {match: {_id: params[:id]}})
    if response.total != 1
      flash[:warning] = 'Threat was not found'
      redirect_to root_path
    else
      @skip_columns = Adminsetting.first.preferences
      @search_result = response.first
      threat_id = @search_result.threat_id

      @tri_rounded = (@search_result.threat_tri*100).round(1)
      @fa_class = case @tri_rounded
                   when 0..33
                     'fa-check'
                   when 34..66
                     'fa-warning'
                   else
                    'fa-times'
                 end

      @histogram_data = []
      Search.indices.each do |index|
        Search.index = index
        response = Search.search(query: {match: {threat_id: threat_id}}).first
        date = Date.strptime(index[9, 10], '%Y.%m.%d')
        if response
          @histogram_data << {date: date.strftime('%F'), tri: response.threat_tri}
        else
          @histogram_data << {date: date.strftime('%F'), tri: 0}
        end
      end
      @histogram_data = @histogram_data.reverse.to_json
      Search.index = Search.indices.first
    end
  end

  def edit
    @skip_columns = Set.new
    @search_result = Search.search(query: {match: {_id: params[:id]}}).first
  end

  def update
    @search_result = Search.search(query: {match: {_id: params[:search][:id]}}).first
    permitted_params = update_params
    @search_result.update_attributes(permitted_params.to_h)
    sleep 3
    flash[:success] = 'Record successfully updated!'
    redirect_to edit_search_url(@search_result)
  end

  def destroy
    begin
      @search_result = Search.search(query: {match: {_id: params[:id]}}).first
      @search_result.destroy
      flash[:success] = 'Record successfully deleted!' if @search_result.destroyed?
    rescue
      flash[:warning] = 'Record could not be deleted!'
    end
    true
  end

  def search_api
    term = '', page_size = 10, page_num = 0, exact_search = true, order_by = '_score', direction = 'desc', regex = false
    term = params[:term] if params.key?(:term)
    regex = params[:regex] if params.key?(:regex)
    page_size = params[:length].to_i if params.key?(:length)
    page_num = params[:start].to_i if params.key?(:start)
    order_by = params[:order_column_name] if params.key?(:order_column_name)
    direction = 'asc' if params.key?(:order_dir) && params[:order_dir] == 'asc'

    search_result = Search.search query: {bool: {should: [{term: {threat_id: term}}, {term: {country: term}}]}},
                                  size: page_size, from: page_num, sort: [{order_by.to_sym => direction}]
    render json: {draw: params[:draw], recordsTotal: search_result.total, recordsFiltered: search_result.total, data: search_result}
  end

  private

  def update_params
    params.require(:search).permit(:confidence, :risk, :type_description, :category_description, :country,
                                   :continent_code, :asn_registry, :host, :threat_tri, :type,
                                   :category, :threat_type, :country_code, :city, :asn, :source_ids => [], :location => [])
  end
end
