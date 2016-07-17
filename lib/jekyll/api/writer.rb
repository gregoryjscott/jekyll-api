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
          generate_json_file('data.json',page,page.path)
        end
        @site.posts.each do |post|
          generate_json_file('post.json',post,post.url)
        end
      end

      def generate_json_file(name,record,base_path)
          path_dir = File.dirname(base_path)
          path_basename = File.basename(base_path, ".*")
          sub_dir = ''
          sub_dir = File.join(sub_dir, path_dir) unless path_dir == '.'
          sub_dir = File.join(sub_dir, path_basename) unless path_basename == 'index'

          path = @site.source
          path = File.join(path, sub_dir) unless sub_dir == ''
          FileUtils.mkdir_p(path) unless Dir.exists?(path)
          
          File.write(File.join(path, name), JSON.dump(record.data))
          json_file = Jekyll::StaticFile.new(@site, @site.source, sub_dir, name)
          @site.static_files << json_file
      end
    end
  end
end
