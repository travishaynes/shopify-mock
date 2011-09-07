# require the Mockify library
require File.expand_path("../../lib/mockify", __FILE__)

# load support files
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each {|f| load f}

# enable Mockify and disable real-world Internet access
Mockify.enabled = true
Mockify.allow_internet = false
