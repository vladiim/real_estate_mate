require_relative '../test_helper'
require_relative '../../lib/conversions/time_conversions'
require 'date'

describe TimeConversions do
  let(:time) { TimeConversions }

  describe '#days_between' do
  	let(:result)  { time.days_between(first, second) }
    let(:earlier) { '14th May' }
    let(:later)   { '24th May' }

  	describe 'first date before second' do
  	  let(:first)  { earlier }
  	  let(:second) { later }

      it 'returns 10' do
      	result.must_equal 10
      end
  	end

  	describe 'second date before first' do
  	  let(:first)  { later }
  	  let(:second) { earlier }

      it 'returns 10' do
      	result.must_equal 10
      end
  	end
  end
end