require 'spec_helper'

describe ShopifyAPI::Mock::DisabledError do
  it { should be_kind_of RuntimeError }
end
