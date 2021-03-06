require 'fileutils'
require 'erb'

RUN_PATH = File.dirname __FILE__

OUT_PATH = 'out'
DEB_PATH = 'debian'

V8_VER = ENV['V8_VER'] || '3.31'
V8_SUBVER = ENV['V8_SUBVER'] || '72'

DEB_SUBVER = ENV['DEB_SUBVER'] || '2'
DEB_VER = "#{V8_VER}.#{V8_SUBVER}-#{DEB_SUBVER}"
DEB_SUBVER
PKG = "libv8-#{V8_VER}"

DEB_CONTROL = 'debian/control'
DEB_RULES   = 'debian/rules'
DEB_COMPAT  = 'debian/compat'
DEB_COPYR   = 'debian/copyright'
DEB_SOURCE  = 'debian/source/format'

GIT_VER = `git log --pretty=format:'%ad %h %d' --abbrev-commit --date=short -1`
CMD_CHANGELOG = %Q(dch --create "#{GIT_VER}" -v #{DEB_VER} --package #{PKG})

TEST_FILE_V8_ROOT_DIR = 'LICENSE.v8'

include FileTest

NPROC = begin
  `nproc`.to_i
rescue
  2
end

task :default => 'debian:files'

namespace :debian do

  task :clean do
    if directory?(DEB_PATH)
      FileUtils.rm_rf DEB_PATH
      puts 'cleaned'
    else
      puts 'already clean'
    end
  end

  desc 'Prepare debian files'
  task :files => ['src:test', :clean] do

    puts "mk deb tree"
    FileUtils.mkdir_p File.join(DEB_PATH, 'source')

    puts "mk control"
    erb = ERB.new(File.read(erb_path DEB_CONTROL))
    File.write DEB_CONTROL, erb.result

    puts "mk rules"
    erb = ERB.new(File.read(erb_path DEB_RULES))
    File.write DEB_RULES, erb.result
    FileUtils.chmod 0755, DEB_RULES

    puts "cp files"
    cp src_path(DEB_COMPAT), DEB_COMPAT
    cp src_path(DEB_COPYR), DEB_COPYR
    cp_r src_path(DEB_SOURCE), DEB_SOURCE

    puts "mk changelog"
    exec CMD_CHANGELOG

  end

  def src_path f
    File.join RUN_PATH, f
  end

  def erb_path f
    File.join RUN_PATH, "#{f}.erb"
  end

end

namespace :src do

  desc 'Test for source tree'
  task :test do
    exists?(TEST_FILE_V8_ROOT_DIR) || raise("Not a v8 root dir")
  end

  desc 'Checkout exact tag'
  task :checkout do
    sh "git checkout -f master"
    sh "git pull"
    sh "git checkout tags/#{V8_VER}.#{V8_SUBVER}"
    sh "gclient sync"
  end

end
