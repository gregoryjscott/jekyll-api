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

  before(:each) do
    clean
    site.process
  end

  it 'creates JSON files for all pages' do
    json_files_count = json_files.count { |file| File.file?(file) }
    assert_equal site.pages.count, json_files_count
  end

  def json_files
    Dir[File.join('_site', '**', 'data.json')]
  end

  def clean
    json_files.each { |json_file| FileUtils.rm(json_file) }
  end

end
