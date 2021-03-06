# encoding: utf-8

require 'yaml'

module Secrets
  class YAML < Inspec.secrets(1)
    name 'yaml'

    attr_reader :attributes

    def self.resolve(target)
      unless target.is_a?(String) && File.file?(target) && ['.yml', '.yaml'].include?(File.extname(target).downcase)
        return nil
      end
      new(target)
    end

    # array of yaml file paths
    def initialize(target)
      @attributes = ::YAML.load_file(target)
    rescue => e
      raise "Error reading Inspec attributes: #{e}"
    end
  end
end
