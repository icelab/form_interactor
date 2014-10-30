require "ostruct"
require "active_support"
require "active_support/core_ext/object"
require "active_model"

module FormInteractor
  ATTRIBUTES_MODULE = :FormInteractorAttributes

  extend ActiveSupport::Concern
  include ActiveModel::Model

  included do
    class_attribute :interactor

    class_attribute :form_model_name

    class_attribute :attribute_names
    self.attribute_names = []
  end

  module ClassMethods
    ### Form DSL

    def attribute(*attr_names)
      self.attribute_names += attr_names

      if const_defined?(ATTRIBUTES_MODULE, _search_ancestors=false)
        mod = const_get(ATTRIBUTES_MODULE)
      else
        mod = const_set(ATTRIBUTES_MODULE, Module.new)
        include mod
      end

      mod.module_eval do
        attr_names.each do |attr_name|
          define_method attr_name do
            result.try(attr_name) || instance_variable_get(:"@#{attr_name}")
          end

          define_method :"#{attr_name}=" do |value|
            instance_variable_set :"@#{attr_name}", value
          end
        end
      end
    end

    ### Commands

    def call(attrs={})
      new(attrs).tap(&:call)
    end

    ### Accessors

    def model_name
      super unless form_model_name.present?

      ActiveModel::Name.new(_klass=self, _namespace=nil, form_model_name)
    end
  end

  ### Commands

  def to_context
    attributes
  end

  def call
    if !valid?
      @failure = true
    else
      @result = interactor.call(to_context.merge(errors: errors))
      @failure = result.failure?
    end

    success?
  end

  ### Accessors

  def attributes
    Hash[attribute_names.map { |name| [name, send(name)] }]
  end

  def result
    @result ||= OpenStruct.new({})
  end

  ### Predicates

  def success?
    !failure?
  end

  def failure?
    @failure || false
  end
end
