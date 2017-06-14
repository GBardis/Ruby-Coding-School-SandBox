class AnalyticsController < ApplicationController


  def show
    @array =[{:key=>'192.168.0.1',:source=>'shallalist.de',:tri=>'11.34%',:risk=>'0.55',:country=>'CountryAA',:asn=>'ASN.1234'}]
    @search = Search.search(query:{match_all:{}},size:10,sort:['threat_tri': { "order": "desc" } ])
    render('show')
  end
end
