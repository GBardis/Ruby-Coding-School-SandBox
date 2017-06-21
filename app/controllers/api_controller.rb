class ApiController < ApplicationController
  require 'elasticsearch/persistence/model'
  require 'elasticsearch/dsl'

  # http://localhost:3000/api/{term}/page_size/{page_size}/page_num/{page_num}/exact_search/{exact_search}/order_by/{order_by}/order_by_direction/{order_by_direction}
  # http://localhost:3000/api/66.197.114/page_size/15/page_num/3
  def search

    term = '', page_size = 10, page_num = 0, exact_search = true, order_by = '_score', direction = 'desc', regex = false

    # Parse params
    if (params.has_key?(:term))
      term = params[:term]
    end
    if (params.has_key?(:regex))
      regex = params[:regex]
    end
    if (params.has_key?(:page_size))
      page_size = params[:page_size].to_i
    end
    if (params.has_key?(:page_num))
      page_num = params[:page_num].to_i
    end
    if (params.has_key?(:order_by))
      order_by = params[:order_by]
    end
    if (params.has_key?(:direction) && params[:direction] == 'asc')
      direction = 'asc'
    end

    search = Search.search query: {term: {threat_id: term}},
                           size: page_size, from: page_num, sort: [{order_by.to_sym => direction}]
    render :json => search
  end

  def threat
    if (params.has_key?(:id))
      id = params[:id]
    elsif
      render
    end

    search = Search.search query: {term: {threat_id: id}}, size: 1
    render :json => search
  end


  def analytics
      @search = Search.search(query:{match_all:{}},size:10,sort:['threat_tri': { "order": "desc" } ])
      @search_country = Search.search(size:0,aggs:{'group_by_country':{'terms':{'field':'country.raw'}}})
      @search_by_tri = Search.search(size:0,aggs:{'group_by_country':{'terms':{'field':'country.raw','order':{'average_threat_tri':'desc'}},aggs:{'average_threat_tri':{avg:{'field':'threat_tri'}}}}})
  end
end
