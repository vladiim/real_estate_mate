module States
  def self.get_state_links(url)
    index        = Mechanize.new.get(url)
    link_columns = index.search('.column')
    add_link_to_urls link_columns
  end

  private

  def self.add_link_to_urls(link_columns)
    links = link_columns.search('dd')
    links.inject([]) { |urls, link| urls << make_allhome_url(link) }
  end

  def self.make_allhome_url(link)
    Allhomes::URL + link.search('a')[0].attributes['href'].value
  end
end