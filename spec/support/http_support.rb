def get(path = [], options = {}, user = MOCKIFY_SHOP[:api_key], pass = MOCKIFY_SHOP[:secret])
  path = parse_path(path)
  options = parse_options(options)
  path = "#{path}?#{options}" unless options.nil?
  
  http = Net::HTTP.new(MOCKIFY_SHOP[:domain], 443)
  http.use_ssl = true
  req = Net::HTTP::Get.new path
  req.basic_auth user, pass
  http.request req
end
