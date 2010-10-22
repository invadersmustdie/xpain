require "spec_helper"

describe "attribute node" do
  def build_single_attribute_node
    XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.attribute "street", :type => "string"
      end
    end
  end

  it "should create a single attribute node" do
    schema = build_single_attribute_node

    schema.doc.xpath("//xsd:attribute").size.should == 1
  end

  it "should have a xsd namespace" do
    schema = build_single_attribute_node
    attribute = schema.doc.xpath("//xsd:attribute").first

    attribute.namespace.prefix.should == "xsd"
    attribute.namespace.href.should == "http://www.w3.org/2001/XMLSchema"
  end

  it "should have name i've set" do
    schema = build_single_attribute_node
    attribute = schema.doc.xpath("//xsd:attribute").first

    attribute['name'].should == "street"
  end

  it "should have type i've set" do
    schema = build_single_attribute_node
    attribute = schema.doc.xpath("//xsd:attribute").first

    attribute['type'].should == "string"
  end
end
