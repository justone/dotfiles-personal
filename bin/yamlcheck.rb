#!/usr/bin/ruby

require 'yaml'

puts YAML.dump(YAML.load_file(ARGV.shift))
