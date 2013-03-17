require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/spec'
# require 'minitest/mock'
require 'minitest/benchmark'
# require 'minitest/debugger'

require 'rr'
require 'turn'
require 'debugger'

require 'fakeweb'
require 'ostruct'

class MockSpec < MiniTest::Spec
   include RR::Adapters::RRMethods
end

# include RR mocks in every description
MiniTest::Spec.register_spec_type(/.*/, MockSpec)