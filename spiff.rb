require "formula"

class Spiff < Formula
  homepage "https://github.com/vito/spiff"
  url "https://github.com/vito/spiff.git", :tag => "v0.2"

  head "https://github.com/vito/spiff.git", :branch => "master"

  depends_on "go" => :build
  depends_on "gocart" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/vito/spiff"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/vito/spiff"
    cd "src/github.com/vito/spiff"
    system "gocart", "install"
    system "go", "install", "github.com/vito/spiff"

    cd buildpath
    bin.install "bin/spiff"
  end

  test do
    system "#{bin}/spiff", "--version"
  end
end
