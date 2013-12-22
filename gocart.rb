require "formula"

class Gocart < Formula
  homepage "https://github.com/vito/gocart"
  url "https://github.com/vito/gocart.git", :branch => "master"
  version "0.1.0"

  head "https://github.com/vito/gocart.git", :branch => "master"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/vito/gocart"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/vito/gocart"
    system "go", "install", "github.com/vito/gocart"

    bin.install "bin/gocart"
  end

  test do
    system "#{bin}/gocart version"
  end
end
