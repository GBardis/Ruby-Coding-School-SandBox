class SearchController < ApplicationController
  require 'elasticsearch/persistence/model'
  require 'elasticsearch/dsl'

  @@SkipColumns = Set.new [:created_at, :updated_at, :_index, :raw_message_bytesize, :logstash_frontend,
                           :vendor_filter_time, :global_filter_time, :logstash_febe_latency_sec, :logstash_backend,
                           :id, :version, :timestamp, :srcevent, :vendor,

                           :host, :confidence_float, :threat_tri_float, :risk,
                           :category, :category_description, :threat_type, :type_description,
                           :location, :country_code, :continent_code, :city, :source_ids
                          ]

  def index
=begin
    if !params[:q]
      #@Search = Search.all(query: { match: { threat_id: '41.222.118.2'}})
      # @Search = Search.all(query: { match: {country_code: 'eth'}})
      @Search = Search.search(query: { match: { '@id': '1fd85a26-fe79-4416-9bc2-9b0d747d00c9' } }, size: 10)
      # @Search = Search.search(query: { match: {country_code: 'eth'}}, size: 10)
    else
      @Search = Search.all(query: { match: {country_code: params[:q]}}, size: 10) unless params[:q].nil?
    end
=end
    @SkipColumns = @@SkipColumns #117.197.209.75
    @Search = Search.search(query: { match: { '@id': '1fd85a26-fe79-4416-9bc2-9b0d747d00c9' } }, size: 1)
    # @Search = Search.search(query: { match_all:{} }, size: 1)

  end

  def show
    @Search = Search.search(query: {match: {_id: params[:id]}}).first
  end

  def edit
    @Search = Search.search(query: {match: {_id: params[:id]}}).first
  end

  def update
    @Search = Search.search(query: {match: {_id: params[:id]}}).first
    @Search.update_attributes(
        threat_id: params[:threat_id],
        asn_registry: params[:asn_registry],
        threat_tri: params[:threat_tri].to_f,
        risk: params[:risk].to_f,
        country: params[:country],
        asn: params[:asn]
    )

    sleep 3
    flash[:success] = 'Record successfully updated!'
    redirect_to search_index_path
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

    # Get search result term: { threat_id: "10.84.205.13" }
    search = Search.search query: {term: {country: term}},
                           size: page_size, from: page_num, sort: [{ order_by.to_sym => direction }]

    # Return data
    render json: {'draw': params[:draw], 'recordsTotal': search.total, 'recordsFiltered': search.total, 'data': search}
  end

end
