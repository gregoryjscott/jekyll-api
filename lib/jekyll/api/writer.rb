require 'fileutils'

module Jekyll
  module API
    class Writer < Jekyll::Generator

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { write_json }
      end

      def write_json
        @site.pages.each do |page|
          json = JSON.dump(page.data)
          path = File.join('api', page.path.sub('.md', '.json'))
          dir = File.dirname(path)
          name = File.basename(path)

          FileUtils.mkdir_p(dir)
          File.write(path, json)
          @site.static_files << Jekyll::StaticFile.new(@site, @site.source, dir, name)
        end
      end

    end
  end
end
