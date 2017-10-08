def post_json(uri, json)
  post(uri, json, { "CONTENT_TYPE" => "application/json" })
end
