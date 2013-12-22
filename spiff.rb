require "formula"

require "fileutils"
require "tmpdir"

class Spiff < Formula
  homepage "https://github.com/vito/spiff"
  url "https://github.com/vito/spiff.git", :tag => "v0.2"

  head "https://github.com/vito/spiff.git", :branch => "master"

  depends_on "go" => :build

  def install
    inreplace Dir["**/*.go"] do

    end

    Dir.mktmpdir do |gopath|
      ENV["GOPATH"] = gopath
      src_path = File.join(gopath, "src", "github.com", "vito", "spiff")
      FileUtils.mkdir_p(src_path)
      system "cp", "-R", "#{buildpath}/", src_path

      system "go", "get", "-d", "github.com/vito/spiff"
      system "go", "install", "github.com/vito/spiff"

      bin.install File.join(gopath, "bin", "spiff")
    end
  end

  test do
    system "#{bin}/spiff", "--version"
  end
end
