module XPain
  module CustomNodes
    def schema(opts = {}, &block)
      create_custom_node("xsd:schema", {"xmlns:xsd" => "http://www.w3.org/2001/XMLSchema"}, &block)
    end

    def include(name)
      create_custom_node("include", {"schemaLocation" => name})
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
        if collection_type == 'none'
          create_custom_node("element", opts.merge!({:name => name}), &block)
        else
          create_custom_node("element", opts.merge!({:name => name})) do
            define_inline_complex_type(collection_type, &block)
          end
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

    def document(text)
      create_custom_node('annotation') do |xsd|
        xsd.documentation text
      end
    end
  end
end
