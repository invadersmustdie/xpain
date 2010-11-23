require "spec_helper"

describe "include node" do
  def build_include_node
    XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.include "more.xsd"
      end
    end
  end

  it "should create a include node" do
    schema = build_include_node

    schema.doc.xpath("//xsd:include").size.should == 1
  end

  it "should include the given file" do
    schema = build_include_node

    schema.doc.xpath("//xsd:include").first.attributes['schemaLocation'].value.should == 'more.xsd'
  end
end
