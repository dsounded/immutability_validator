$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'immutability_validator'

require 'rubygems'
require 'rspec'
require 'active_model'

class TestModel
  include ActiveModel::Validations
  include ActiveModel::Dirty

  define_attribute_methods :name

  def self.model_name
    ActiveModel::Name.new(self, nil, 'test')
  end

  attr_reader :name

  def initialize(attributes = {})
    @attributes = attributes
    @name = attributes.fetch(:name)
  end

  def name=(val)
    name_will_change! unless val == @name
    @name = val
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def save
    changes_applied
  end

  def reload!
    clear_changes_information
  end

  def rollback!
    restore_attributes
  end
end
