require "spec_helper"

describe "complex type definition node" do
  def build_single_complex_type_node
    XPain::Builder.new do |xsd|
      xsd.schema do
        xsd.define_complex_type "mystring" do
          xsd.extension :base => "string" do
            xsd.attribute :name => "type", :type => "string", :use => "optional"
          end
        end
      end
    end
  end

  it "should create a single complex type node" do
    schema = build_single_complex_type_node

    schema.doc.xpath("//xsd:complexType").size.should == 1
  end

  it "should contain simpleContent by default" do
    schema = build_single_complex_type_node

    schema.doc.xpath("//xsd:complexType[1]/xsd:simpleContent").size.should == 1
  end

  it "should contain an extension" do
    schema = build_single_complex_type_node

    schema.doc.xpath("//xsd:complexType[1]/xsd:simpleContent/xsd:extension[@base='string']").size.should == 1
  end

  it "should overwrite an attribute" do
    schema = build_single_complex_type_node

    schema.doc.xpath("//xsd:complexType[1]/xsd:simpleContent/xsd:extension[@base='string']/xsd:attribute[@type='string' and @name='type' and @use='optional']").size.should == 1
  end
end
