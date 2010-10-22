module XPain
  class Builder < Nokogiri::XML::Builder
    include XPain::CustomNodes

    private

    def declare_namespace!
      return @ns if @ns

      if @parent != doc
        default_ns = @parent.namespace_definitions.first
        @ns = default_ns if default_ns
      end
    end

    def create_custom_node(name, opts = {}, &block)
      declare_namespace!

      opts = OptionsEnhancer.new(opts).enhance

      node = @doc.create_element(name, opts) do |n|
        n.namespace = @ns
      end

      insert(node, &block)
    end
  end
end
