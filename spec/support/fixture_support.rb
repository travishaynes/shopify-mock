def read_fixture(name, ext = :json)
  File.read(File.expand_path("../../../lib/mockify/fixtures/%s", __FILE__) %
    "#{name.to_s}.#{ext.to_s}"
  )
end
