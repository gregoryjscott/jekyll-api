require 'fileutils'

module Jekyll
  module API
    class Writer < Jekyll::Generator

      priority :low

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { write_json }
      end

      def write_json
        @site.pages.each do |page|
          page_dir = File.dirname(page.path)
          page_name = File.basename(page.path, ".*")
          sub_dir = ''
          sub_dir = File.join(sub_dir, page_dir) unless page_dir == '.'
          sub_dir = File.join(sub_dir, page_name) unless page_name == 'index'

          path = @site.source
          path = File.join(path, sub_dir) unless sub_dir == ''
          FileUtils.mkdir_p(path) unless Dir.exists?(path)

          name = 'data.json'
          File.write(File.join(path, name), JSON.dump(page.data))
          json_file = Jekyll::StaticFile.new(@site, @site.source, sub_dir, name)
          @site.static_files << json_file
        end
      end

    end
  end
end
