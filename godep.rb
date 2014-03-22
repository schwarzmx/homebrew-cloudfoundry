require "formula"

class Godep < Formula
  homepage "https://github.com/tools/godep"
  url "https://github.com/tools/godep.git",
    :revision => "ff73059bf44971ba057833de6b39a4bc3c80491f"
  version "0.1"

  head "https://github.com/cloudfoundry-incubator/spiff.git", :branch => "master"

  depends_on "mercurial" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/tools/godep"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/tools/godep"
    cd "src/github.com/tools/godep"
    system "go", "get", "-d", "github.com/tools/godep"
    system "go", "install", "github.com/tools/godep"

    cd buildpath
    bin.install "bin/godep"
  end

  test do
    system "#{bin}/godep"
  end
end
