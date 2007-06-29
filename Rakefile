# Copyright (c) 2007 Samuel Tesla

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require File.join(File.dirname(__FILE__), 'config', 'environment.rb')
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/testtask'
require 'rubygems'

task :default => ['test:all']

CLEAN.include "ext/**/*.bundle", "ext/**/*.o"
CLOBBER.include "ext/Makefile", "ext/base32", "pkg/**/*"

PKG_VERSION = "1.0.0"
PKG_FILES = FileList["Rakefile",
                     "{config,lib,test}/**/*",
                     "ext/*.{c,h,rb}",
                     "ext/base32/base32_ext.bundle"]

gemspec = Gem::Specification.new do |s|
  s.name = 'base32'
  s.version = PKG_VERSION
  s.author = "Samuel Tesla"
  s.email = "samuel@thoughtlocker.net"
  s.summary = "Ruby extension for base32 encoding and decoding"
  s.requirements << 'none'
  s.require_paths << 'ext'
  s.files = PKG_FILES
  s.extensions = ["ext/extconf.rb"]
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_tar = true
end


namespace :test do
  Rake::TestTask.new :all => [:extension] do |t|
    t.libs << 'test'
    t.libs << 'ext'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:all'].comment = 'Run all of the tests'

  task :extension => "ext/base32/base32_ext.bundle"

  Rake::FileCreationTask.define_task "ext/base32" do
    mkdir "ext/base32"
  end

  file "ext/base32/base32_ext.bundle" => ["ext/base32", "ext/base32_ext.bundle"] do |t|
    cp "ext/base32_ext.bundle", t.name
  end

  extension_source = FileList["ext/**/*.c", "ext/**/*.h"]

  file "ext/base32_ext.bundle" => ["ext/Makefile", *extension_source] do
    cd "ext" do
      sh "make"
    end
  end

  file "ext/Makefile" => "ext/extconf.rb" do
    cd "ext" do
      ruby "extconf.rb"
    end
  end
end