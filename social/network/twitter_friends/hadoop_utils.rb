module HadoopUtils


  String.class_eval do
    def scrub!
      gsub!(/[\t\r\n]+/, ' ')  # KLUDGE
    end

    # Stolen from active_support
    #
    # The reverse of +camelize+. Makes an underscored, lowercase form from the expression in the string.
    #
    # Changes '::' to '/' to convert namespaces to paths.
    #
    # Examples:
    #   "ActiveRecord".underscore         # => "active_record"
    #   "ActiveRecord::Errors".underscore # => active_record/errors
    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end
  end
  Array.class_eval do
    def to_tsv options={}
      to_csv options.merge( :col_sep => "\t" )
    end
  end
  def scrub hsh, *fields
    fields.each{|field| hsh[field.to_s].scrub! if hsh[field.to_s] }
  end


  module HadoopStructMethods
    def initialize origin, timestamp, hsh
      self.origin = origin
      self.timestamp = timestamp
      self.indifferent_merge! hsh
    end
    #
    def resource
      self.class.to_s.underscore
    end
    # identifying output key
    def key
      [resource, id].join('-')
    end
    # dump to stdout
    def emit
      puts [ key, timestamp, origin, *self.values ].to_tsv
    end
  end

  class HadoopStruct
    def self.new *members
      Struct.new(*members, :origin, :timestamp)
    end
  end
end