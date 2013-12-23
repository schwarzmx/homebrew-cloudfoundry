require "formula"

class Gosh < Formula
  homepage "https://github.com/xoebus/gosh"
  head "https://github.com/xoebus/gosh.git", :branch => "master"

  depends_on "go" => :build
  depends_on "gocart" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/xoebus/gosh"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/xoebus/gosh"
    cd "src/github.com/xoebus/gosh"
    system "gocart", "install"
    system "go", "install", "github.com/xoebus/gosh"

    cd buildpath
    bin.install "bin/gosh"
  end

  test do
    system "#{bin}/gosh", "--help"
  end
end
