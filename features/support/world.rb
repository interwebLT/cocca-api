require 'minitest/spec'

World(MiniTest::Assertions)
MiniTest::Spec.new(nil)

require 'webmock/cucumber'

World(FactoryGirl::Syntax::Methods)

require 'minitest/mock'
