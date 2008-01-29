module Thin
  # Store HTTP header name-value pairs direcly to a string
  # and allow duplicated entries on some names.
  class Headers
    HEADER_FORMAT      = "%s: %s\r\n".freeze
    ALLOWED_DUPLICATES = %w(Set-Cookie Set-Cookie2 Warning WWW-Authenticate).freeze
    
    def initialize
      @sent = {}
      @out = ''
    end
    
    # Add <tt>key: value</tt> pair to the headers.
    # Ignore if already sent and no duplicates are allowed
    # for this +key+.
    def []=(key, value)
      if !@sent.has_key?(key) || ALLOWED_DUPLICATES.include?(key)
        @sent[key] = true
        @out << HEADER_FORMAT % [key, value]
      end
    end
    
    def to_s
      @out
    end
  end
end