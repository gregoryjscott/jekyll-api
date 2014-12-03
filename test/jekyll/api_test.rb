require 'jekyll/api'
require 'minitest/autorun'

describe 'Jekyll::API' do

  let(:config) do
    Jekyll.configuration({
      'source' => 'test/fixtures',
      'permalink' => 'pretty',
      'quiet' => true
    })
  end

  let(:site) { Jekyll::Site.new(config) }

  before(:each) { site.process }

  it 'creates JSON files for all pages' do
    page_count = site.pages.count
    json_count = Dir[File.join(File.join('_site', 'api'), '**', '*')].count { |file| File.file?(file) }

    assert_equal page_count, json_count
  end

end
