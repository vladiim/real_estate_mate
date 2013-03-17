require_relative '../../test_helper'
require_relative '../../../lib/scrapers/allhomes/scraper'

describe Allhomes::Scraper do
  let(:scraper)   { Allhomes::Scraper.new }
  let(:site)      { Allhomes }

  describe '.initialize' do
    it 'composes collaborators' do
      scraper.agent.class.must_equal Mechanize
      scraper.site.must_equal site
    end
  end

  describe 'mechanize mock' do
    let(:mechanize) { Object.new }
    let(:scraper)   { Allhomes::Scraper.new(mechanize) }

    describe "#find_state_links" do
      describe 'index has one page' do
        let(:act_url) { 'URL' }
        let(:act)     { OpenStruct.new allhomes_index_url: act_url }

        before do
          mock(site).act { act }
          mock(mechanize).get(anything) { OpenStruct.new links: 'ACT LINKS' }
          scraper.find_state_links('act')
        end

        it 'sets the page to the act index page' do
          scraper.links.must_equal 'ACT LINKS'
        end
      end
    end
  end
end