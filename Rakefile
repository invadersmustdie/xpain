require 'rubygems'
require 'spec/rake/spectask'
require 'rake/gempackagetask'

PKG_VERSION = "0.0.1"

Spec::Rake::SpecTask.new do |t|
 t.spec_files = FileList['spec/*_spec.rb']
end

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "ruby dsl for creating xsd's"
  s.name = 'xpain'
  s.version = PKG_VERSION
  s.requirements << 'nokogiri'
  s.require_path = 'lib'
  s.autorequire = 'rake'
  s.files = FileList["{lib,spec,Rakefile}/**/*"]
  s.executables = ['xpain']
  s.description = <<EOF
  ruby dsl for creating xsd's
EOF
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end
