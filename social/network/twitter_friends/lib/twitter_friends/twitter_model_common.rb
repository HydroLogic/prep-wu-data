module TwitterModelCommon
  # ===========================================================================
  #
  # Dump fields, tab-separated, in order given by +#members+
  #
  # Array#to_tsv is expensive but does all the escaping we need. Override with
  #   self.to_a.join("\t")
  # if you're impatient and know what you're doing.
  #
  def to_tsv
    self.to_a.to_tsv
  end

  #
  # dump resource name and all fields, tab-separated
  #
  def output_form
    [resource_name, self.to_tsv].join("\t")
  end

  # ===========================================================================
  #
  # express the class type
  #
  def resource_name
    self.class.to_s.underscore
  end
  #
  # emit an identifiable resource name that will partition kindof efficiently at
  # the reducer.
  #
  # Ex.
  #   a = TwitterUser.new; a.id = '0004567890'; a.keyspace_spread_resource_name
  #   # => "twitter_user-90"
  #
  def keyspace_spread_resource_name
    "%s-%s" % [ self.resource_name, self.key[-2..-1] ]
  end

  # ===========================================================================
  #
  # Field conversions
  #
  # Make the data easier for batch flat-record processing
  #

  # Format for date-string conversion
  DATEFORMAT = "%Y%m%d%H%M%S"
  #
  # Convert date into flat, uniform format
  # Note that DateTime.parse will still roundtrip the flattened date.
  #
  def self.flatten_date dt
    DateTime.parse(dt).strftime(DATEFORMAT) if dt
  end

  #
  # Zero-pad IDs to a full 10 digits (the max digits for an unsigned 32-bit
  # integer).
  #
  # nil id will be encoded as 0.  Shit happens and we'd rather be idempotent
  # than picky.
  #
  # Note that sometime in 2010 (or sooner, depending on its growth rate: in 2008
  # Dec it was 1.8M/day) the status_id will exceed 32 bits.  Something will
  # happen then.
  #
  def self.zeropad_id id
    id ||= 0
    '%010d' % [id.to_i]
  end

  #
  # Express boolean as 1 (true) or 0 (false).
  #
  def self.unbooleanize bool
    bool ? 1 : 0
  end


end