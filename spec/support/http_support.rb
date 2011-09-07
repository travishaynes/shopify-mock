def get(path = [], options = {}, user = "api_key", pass = "token")
  path = parse_path(path)
  options = parse_options(options)
  path = "#{path}?#{options}" unless options.nil?
  
  http = Net::HTTP.new("test.myshopify.com", 443)
  http.use_ssl = true
  req = Net::HTTP::Get.new path
  req.basic_auth user, pass
  http.request req
end
