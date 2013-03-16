require_relative '../test_helper'
require_relative '../../lib/scrapers/allhomes_scraper'

describe Allhomes::Scraper do
  let(:scraper) { Allhomes::Scraper.new }
  let(:site)    { Allhomes }

  describe '.initialize' do
    it 'composes collaborators' do
      scraper.worker.class.must_equal Mechanize
      scraper.site.must_equal site
    end
  end

  describe "#visit_state" do
    let(:act)  { Object.new }
    let(:result) { scraper.visit_state('act') }

    before do
      mock(site).act { act }
      @stream = File.open "#{scraper_dir}/state_sale_list.html", "r"
      FakeWeb.register_uri(:get, act_url, body: @stream, content_type: 'text/html')
    end

    after { @stream.close }

    it 'sets the page to the act index page' do
      scraper.page.must_equal @stream
    end
  end
end

# module State
#   class Act
#     def url
#       'http://www.allhomes.com.au/ah/act/sale-residential'
#     end
#   end
# end

def scraper_dir
  "#{Dir.pwd}/test/fixtures/allhomes"
end

def act_url
  "http://www.allhomes.com.au/ah/act/sale-residential"
end