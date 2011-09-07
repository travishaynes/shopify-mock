def parse_path(path = [], ext = :json)
  path = [path] unless path.class == Array
  "/admin/" << path.map {|p| p.to_s}.join("/") << ".#{ext.to_s}"
end

def parse_options(options = {})
  options.map {|k,v| "#{k}=#{v}"}.join("&")
end
