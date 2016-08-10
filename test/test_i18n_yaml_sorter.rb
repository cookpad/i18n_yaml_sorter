require File.dirname(__FILE__) + '/helper'

class TestI18nYamlSorter < MiniTest::Test
  def test_should_sort_complex_sample_file
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_rails_i18n_default_file
    open(File.dirname(__FILE__) + '/in_rails.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_rails.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_sort_simple_text_file
    open(File.dirname(__FILE__) + '/in_simple.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_simple.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_sort_uncommon_keys_correctly
    open(File.dirname(__FILE__) + '/in_uncommon.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_uncommon.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_preserve_empty_line_when_the_options_is_set_to_false
    open(File.dirname(__FILE__) + '/in_empty_line.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file, discard_empty_line: false)
      open(File.dirname(__FILE__) + '/out_empty_line.yml') do |expected_out|
        assert_equal expected_out.read, sorter.sort
      end
    end
  end

  def test_should_not_alter_the_serialized_yaml
    #ordering should'n t change a thing, since hashes don't have order in Ruby
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      present = YAML::load(file.read)
      file.rewind
      future = YAML::load(sorter.sort)
      assert_equal present, future
    end
  end

  def test_command_line_should_work_in_stdin
    output = `#{File.dirname(__FILE__)}/../bin/sort_yaml < #{File.dirname(__FILE__)}/in.yml`
    open(File.dirname(__FILE__) +  '/out.yml') do |expected_out|
      assert_equal expected_out.read, output
    end
  end
end
