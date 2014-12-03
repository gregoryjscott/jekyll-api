require 'fileutils'

module Jekyll
  module API
    class Writer < Jekyll::Generator

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { write_json }
      end

      def write_json
        FileUtils.rm_r('api') if Dir.exists?('api')

        @site.pages.each do |page|
          json = JSON.dump(page.data)
          path = File.join('api', page.path.sub('.md', '.json'))
          FileUtils.mkdir_p(File.dirname(path))
          File.write(path, json)
        end
      end

    end
  end
end
