class SearchController < ApplicationController
  require 'elasticsearch/persistence/model'
  require 'elasticsearch/dsl'

  def index
    if !params[:q]
      #@Search = Search.all(query: { match: { threat_id: '41.222.118.2'}})
      # @Search = Search.all(query: { match: {country_code: 'eth'}})
      @Search = Search.search(query: { match: { '@id': 'c1681c3d-a456-425a-b785-3681e24eec6c' } }, size: 10)
      # @Search = Search.search(query: { match: {country_code: 'eth'}}, size: 10)
    else
      @Search = Search.all(query: { match: {country_code: params[:q]}}, size: 10) unless params[:q].nil?
    end
  end

  def show
    @Search = Search.search(query:{match: {_id: params[:id]}}).first
  end

  def edit
    @Search = Search.search(query:{match: {_id: params[:id]}}).first
  end

  def update
    @Search = Search.search(query:{match: {_id: params[:id]}}).first
    @Search.update_attributes(
      threat_id: params[:threat_id],
      asn_registry: params[:asn_registry],
      threat_tri: params[:threat_tri].to_f,
      risk: params[:risk].to_f,
      country:  params[:country],
      asn:  params[:asn]
    )

    sleep 3
    flash[:success] = 'Record successfully updated!'
    redirect_to search_index_path
  end

  def destroy
    begin
      @s = Search.search(query:{match: {_id: params[:id]}}).first
      @s.destroy
      flash[:success] = 'Record successfully deleted!'  if @s.destroyed?
    rescue
    end
    sleep 3
    redirect_to search_index_path
  end

  def search_api
    if (!params.has_key?(:term) || !params[:term] || params[:term].length == 0)
      render json: '' and return
    end
    if params.has_key?(:page_size)
      page_size = Integer(params[:page_size]) rescue 0
    else
      page_size = 10
    end
    if params.has_key?(:page_num)
      page_num = Integer(params[:page_num]) rescue 0
    else
      page_num = 0
    end
    if (params.has_key?(:exact_search) && params[:exact_search] == 'false')
      exact_search = false
    else
      exact_search = true
    end

    if (params.has_key?(:order_by))
      order_by = params[:order_by]
    else
      order_by = ''
    end

    if (params.has_key?(:order_by_direction))
      order_by_direction = params[:order_by_direction]
    else
      order_by_direction = ''
    end

    render json: {'draw': draw, 'recordsTotal': recordsTotal, 'recordsFiltered': recordsFiltered, 'data': data}
  end
end
