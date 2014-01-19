require "formula"

class Shank < Formula
  homepage "https://github.com/vito/shank"
  head "https://github.com/vito/shank.git", :branch => "master"

  depends_on "go" => :build
  depends_on "gocart" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/vito/shank"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/vito/shank"
    cd "src/github.com/vito/shank"
    system "gocart", "install"
    system "go", "install", "github.com/vito/shank"

    cd buildpath
    bin.install "bin/shank"
  end

  test do
    system "#{bin}/shank", "--version"
  end
end
