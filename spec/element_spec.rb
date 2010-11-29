require "spec_helper"

describe "element node" do
  def build_single_element_node
    XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.element "street", :type => "string"
      end
    end
  end

  it "should create a single element node" do
    schema = build_single_element_node

    schema.doc.xpath("//xsd:element").size.should == 1
  end

  it "should have a xsd namespace" do
    schema = build_single_element_node
    element = schema.doc.xpath("//xsd:element").first

    element.namespace.prefix.should == "xsd"
    element.namespace.href.should == "http://www.w3.org/2001/XMLSchema"
  end

  it "should have name i've set" do
    schema = build_single_element_node
    element = schema.doc.xpath("//xsd:element").first

    element['name'].should == "street"
  end

  it "should have type i've set" do
    schema = build_single_element_node
    element = schema.doc.xpath("//xsd:element").first

    element['type'].should == "string"
  end

  it "should have elements with complex type" do
    schema = XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.element "customer" do
          xsd.element "customer_number", :type => "mystring"
        end
      end
    end

    element = schema.doc.xpath("//xsd:element/xsd:complexType/xsd:all/xsd:element").first

    element['name'].should == 'customer_number'
  end
end
