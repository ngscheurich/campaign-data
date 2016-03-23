require "sinatra"
require "httparty"
require "active_support/core_ext/hash"

get "/" do
  before do
    response.headers["Access-Control-Allow-Origin"] = "*"
  end

  content_type :json

  base_uri = "https://braiservices.dticloud.com/cgi-bin/hm_hm.sh/interface/adplus/lib/interface"
  query = {
    ActionType: "RunProg",
    ProgName: "MCampaign",
    ZipCode: request["ZipCode"]
  }

  response = HTTParty.get(base_uri, query: query)
  xml = response.body
  Hash.from_xml(xml).to_json
end
