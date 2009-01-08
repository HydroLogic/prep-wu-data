require 'fileutils'; include FileUtils


class TarScrapeStore
  attr_accessor :tar_filename
  def initialize tar_filename
    self.tar_filename = tar_filename
  end

  # Base path for temporary extraction
  LOCAL_EXTRACT_DIR = '/workspace/flip/data/ripd'
  #
  # Where to extract files temporarily
  #
  def extract_dir
    LOCAL_EXTRACT_DIR + '/' + tar_filename.gsub(/\..*$/, '')
  end

  def listing
    `hdp-cat #{tar_filename} | tar tjvf - | egrep '\.json$'`.split("\n")
  end

  def target
    m = %r{ripd-(\d+)-([\w-]+)}.match(tar_filename) or raise "Can't grok #{tar_filename}"
    scrape_session, resource_path = m.captures
    "_com/_tw/com.twitter/_%s/%s" % [scrape_session, resource_path.gsub(/-/, '/')]
  end

  def extracted?
    File.exists?(extract_dir + '/' + target)
  end

  def extract!
    $stderr.puts [tar_filename, extracted?, extract_dir, target].inspect
    if ! extracted?
      mkdir_p extract_dir
      cd extract_dir do
        `hdp-cat #{tar_filename} | tar xjfk - --mode 644`
      end
    end
  end

  def extracted_files
    cd extract_dir do
      return Dir['**/*.json']
    end
  end

  def contents &block
    cd extract_dir do
      extracted_files.each do |scraped_filename|

        # Grok filename
        scraped_file = ScrapedFile.new_from_filename scraped_filename, nil

        # extract file's contents
        contents = File.open(scraped_filename).read
        next if (! contents) || contents.empty?
        contents = contents.gsub(/\s+\z/, '').gsub(/[\t\r\n]+/, ' ')

        # process
        yield scraped_file, contents
      end
    end
  end
end



# TAR_RE = %r{(public_timeline)-([\d-]+)(?:-partial)?\.tar\.bz2}
# def tar_contents_dir tar_filename
#   m = TAR_RE.match(tar_filename) or raise "Can't grok archive filename '#{tar_filename}'"
#   resource, scrape_session = m.captures
#   resource.gsub!(/\-/, '/') ; scrape_session.gsub!(/\-/, '/')
#   "#{resource}/#{scrape_session}"
# end
