require 'active_model'
require 'i18n'

class ImmutabilityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _)
    return if record.new_record?

    record.errors.add(attribute, options[:message] || I18n.t('.activerecord.errors.base.immutability')) if record.attribute_changed?(attribute)
  end
end

module ClassMethods
  def validates_immutability_of(*attr_names)
    validates_with ImmutabilityValidator, _merge_attributes(attr_names)
  end
end
