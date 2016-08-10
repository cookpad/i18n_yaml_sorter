require 'i18n_yaml_sorter'

namespace :i18n do

  desc "Sort locales keys in alphabetic order. Sort all locales if no path parameter given"

  task :sort, [:path_to_file, :discard_empty_line] => :environment do |t , args|
    locales = args[:path_to_file] || Dir.glob("#{Rails.root}/config/locales/**/*.yml")
    options = {}
    options[:discard_empty_line] = args[:discard_empty_line] == "1"

    locales.each do |locale_path|
      sorted_contents = File.open(locale_path) { |f| I18nYamlSorter::Sorter.new(f, options).sort }
      File.open(locale_path, 'w') { |f|  f << sorted_contents}
    end
  end

end
