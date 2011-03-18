# encoding: utf-8

module LocalizedKeys

  extend ActiveSupport::Concern

  included do |base|

    before_validation :normalize_language

  end


  module ClassMethods

    def localized_keys
      @localized_keys ||= []
    end

    def default_language(instance = nil)
      if @default_language.respond_to?(:call)
        @default_language.call
      elsif @default_language.is_a?(Symbol)
        instance && instance.send(@default_language)
      else
        @default_language
      end
    end

    def default_language=(language)
      @default_language = language
    end

    def i18n_field(name, options = {})
      localized_keys << name
      self.default_language = options.delete(:default_language) if options[:default_language]

      # Define MongoMapper key
      key_name = "#{name}_locales"
      self.field key_name, options.merge(:type => Hash, :default => {})

      # Define a getter method
      define_method(name) do |*args|
        locale = (args.empty? || args.first.nil?) ?
          self.class.default_language(self) :
          args.first
        locale_attr = read_attribute(key_name)
        locale = locale_attr.keys.first unless locale
        p locale
        locale_attr[locale || ''] if locale_attr
      end

      # Define a setter method
      define_method(:"#{name}=") do |*args|
        locale_attr = read_attribute(key_name)
        write_attribute(key_name, {}) unless locale_attr
        read_attribute(key_name)[self.class.default_language(self) || ''] = args.first
      end

      # Define a query method
      define_method(:"#{name}?") do |*args|
        self.send(name, *args).present?
      end
    end

  end


  module InstanceMethods

    def method_missing(name, *args)
      if self.respond_to_dynamic?(name)
        name.to_s =~ /(.*)_([a-z]{2})(=)??$/
        key, locale, assignment = $1, $2, $3
        localized_key = :"#{key}_locales"

        if assignment.nil?
          value = send(localized_key)
          value[locale] if value
        elsif
          value = send(localized_key)
          send(:"#{localized_key}=", {}) unless value
          send(localized_key)[locale] = args.first
        end
      else
        super
      end
    end

    def respond_to?(*args)
      super || self.respond_to_dynamic?(args.first)
    end

    protected

    def respond_to_dynamic?(name)
      if name.to_s =~ /(.*)_([a-z]{2})=?$/
        key = $1
        self.class.localized_keys.include?(key.to_sym)
      else
        false
      end
    end

    def normalize_language
      self.class.localized_keys.each do |key|
        locales = self.send(:"#{key}_locales")

        if locales && locales.has_key?("") && default = self.class.default_language(self)
          locales[default] = locales[""]
          locales.delete("")
        end
      end
    end

  end

end

