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
    generated_files = File.join(Dir.pwd, 'test', 'fixtures', 'api')
    FileUtils.rm_r(generated_files) if Dir.exists?(generated_files)

    site.process
  end

  it 'creates JSON files for all pages' do
    page_count = site.pages.count

    json_dir = File.join(File.join('_site', 'api'), '**', '*')
    json_count = Dir[json_dir].count { |file| File.file?(file) }

    assert_equal page_count, json_count
  end

end
