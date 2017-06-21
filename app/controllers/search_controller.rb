require 'elasticsearch/model'
require 'elasticsearch/persistence/model'
require 'elasticsearch/dsl'
class SearchController < ApplicationController

  def index
    if (Adminsetting.count == 0)
      a = Adminsetting.new
      a.save
    end
    @SkipColumns = Set.new
    @Search = Search.search(query: {match_all: {}}, size: 1)
    Adminsetting.first.preferences.each do |name, value|
      if value.to_i == 0
        @SkipColumns.add(name.to_sym)
      end
    end
  end

  def show
    response = Search.search(query: {match: {_id: params[:id]}})
    byebug
    if response.total != 1
      byebug
      redirect_to root_path
    else
      @SkipColumns = Set.new
      Adminsetting.first.preferences.each do |name, value|
        if value.to_i == 0
          @SkipColumns.add(name.to_sym)
        end
      end
      @Search = response.first
      threat_id = @Search.threat_id
      @HistogramData = Array.new
      Search.indices.each do |index|
        Search.index = index
        response = Search.search(query: {match: {threat_id: threat_id}}).first
        date = Date.strptime(index[9, 10], '%Y.%m.%d')
        if (response)
          @HistogramData << {:date => date.strftime('%F'), :tri => response.threat_tri, }
        else
          @HistogramData << {:date => date.strftime('%F'), :tri => 0}
        end
      end
      @HistogramData = @HistogramData.reverse.to_json
    end
  end

  def edit
    @SkipColumns = Set.new
    @Search = Search.search(query: {match: {_id: params[:id]}}).first
  end

  def update
    @Search = Search.search(query: {match: {_id: params[:id]}}).first
    # TODO: update all attributes
    @Search.update_attributes(
        threat_id: params[:threat_id],
        threat_tri: params[:threat_tri].to_f
    )

    sleep 3
    flash[:success] = 'Record successfully updated!'
    # redirect_to search_index_path
    redirect_to edit_search_url(@Search)
  end

  def destroy
    begin
      @s = Search.search(query: {match: {_id: params[:id]}}).first
      @s.destroy
      flash[:success] = 'Record successfully deleted!' if @s.destroyed?
    rescue
    end
    sleep 3
    redirect_to search_index_path
  end

  def search_api
    #@data = elastic_search params[:term], page_size, page_num, exact_search, order_by, order_by_direction
    #{"draw"=>"4", "start"=>"0", "length"=>"25", "term"=>"", "regex"=>"false", "order_column_name"=>"updated_at", "order_dir"=>"desc"}

    term = '', page_size = 10, page_num = 0, exact_search = true, order_by = '_score', direction = 'desc', regex = false

    # Parse params
    if (params.has_key?(:term))
      term = params[:term]
    end
    if (params.has_key?(:regex))
      regex = params[:regex]
    end
    if (params.has_key?(:length))
      page_size = params[:length].to_i
    end
    if (params.has_key?(:start))
      page_num = params[:start].to_i
    end
    if (params.has_key?(:order_column_name))
      order_by = params[:order_column_name]
    end
    if (params.has_key?(:order_dir) && params[:order_dir] == 'asc')
      direction = 'asc'
    end

    # Get search result term:
    # {"query":{"bool":{"should":[{"match":{"threat_id":"greece"}},{"match":{"country":"greece"}}]}}}
    search = Search.search query: {bool: {should: [{term: {threat_id: term}}, {term: {country: term}}]}},
                           size: page_size, from: page_num, sort: [{order_by.to_sym => direction}]

    # Return data
    render json: {'draw': params[:draw], 'recordsTotal': search.total, 'recordsFiltered': search.total, 'data': search}
  end

end
