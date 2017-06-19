class AnalyticsController < ApplicationController


  def show
    @search = Search.search(query:{match_all:{}},size:10,sort:['threat_tri': { "order": "desc" } ])
    @search_country = Search.search(size:0,aggs:{'group_by_country':{'terms':{'field':'country.raw'}}})
    @search_by_tri = Search.search(size:0,aggs:{'group_by_country':{'terms':{'field':'country.raw','order':{'average_threat_tri':'desc'}},aggs:{'average_threat_tri':{avg:{'field':'threat_tri'}}}}})

  end
end
