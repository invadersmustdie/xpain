module XPain
  class Builder < Nokogiri::XML::Builder
    def schema(opts = {}, &block)
      create_custom_node("xsd:schema", {"xmlns:xsd" => "http://www.w3.org/2001/XMLSchema"}, &block)
    end

    def define_complex_type(name, opts = {}, &block)
      node_type = opts.delete(:contains) || "simpleContent"

      create_custom_node("complexType", :name => name) do
        create_custom_node(node_type, opts, &block)
      end
    end

    def define_inline_complex_type(collection_type = "simpleContent", &block)
      create_custom_node("complexType") do
        create_custom_node(collection_type, &block)
      end
    end

    def element(name, opts = {}, &block)
      collection_type = opts.delete(:contains) || "all"

      if block_given?
        create_custom_node("element", :name => name) do
          define_inline_complex_type(collection_type, &block)
        end
      else
        create_custom_node("element", opts.merge!({:name => name}))
      end
    end

    def attribute(name, opts = {})
      if name.is_a?(String)
        opts.merge!({:name => name})
      else
        opts.merge!(name)
      end

      create_custom_node("attribute", opts)
    end

    def elements(list, opts = {})
      list.each do |li|
        element(li, opts)
      end
    end

    private

    def declare_namespace!
      return @ns if @ns

      if @parent != doc
        default_ns = @parent.namespace_definitions.first
        @ns = default_ns if default_ns
      end
    end

    def extend_custom_ops(opts = {})
      if opts[:min]
        v = opts.delete(:min)
        opts[:minOccurs] = v
      end

      opts
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