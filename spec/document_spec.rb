require "spec_helper"

describe "nested documentation node" do
  def build_nested_documentation_node
    XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.element "street", :type => "string", :contains => 'none' do
          xsd.document "some doc"
        end
      end
    end
  end

  def build_nested_documentation_in_complex_type_node
    XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.element "adress" do
          xsd.document "more doc"
          xsd.element "street", :type => 'string'
        end
      end
    end
  end

  it "should have annotation element" do
    schema = build_nested_documentation_node

    schema.doc.xpath("//xsd:element/xsd:annotation").size.should == 1
  end

  it "should have documentation element" do
    schema = build_nested_documentation_node

    schema.doc.xpath("//xsd:element/xsd:annotation/xsd:documentation").size.should == 1
  end

  it "should contain given documentation string" do
    schema = build_nested_documentation_node

    schema.doc.xpath("//xsd:element/xsd:annotation/xsd:documentation").first.children.first.text.should == 'some doc'
  end

  it "should contain documentation string in complex types" do
    schema = build_nested_documentation_in_complex_type_node

    schema.doc.xpath("//xsd:complexType/xsd:all/xsd:annotation/xsd:documentation").first.children.first.text.should == 'more doc'
  end

end
