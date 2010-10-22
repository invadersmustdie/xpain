module XPain
  class OptionsEnhancer
    ENH_MAP = {
      :min => :minOccurs,
      :max => :maxOccurs
    }

    def initialize(opts = {})
      @opts = opts
    end

    def enhance
      ENH_MAP.each do |matcher, replacement|
        if @opts[matcher]
          value = @opts.delete(matcher)
          @opts[replacement] = value
        end
      end

      @opts
    end
  end
end
