require "formula"

class Spiff < Formula
  homepage "https://github.com/cloudfoundry-incubator/spiff"
  url "https://github.com/cloudfoundry-incubator/spiff.git", :tag => "v0.3"

  head "https://github.com/cloudfoundry-incubator/spiff.git", :branch => "master"

  depends_on "go" => :build
  depends_on "gocart" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/cloudfoundry-incubator/spiff"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/cloudfoundry-incubator/spiff"
    cd "src/github.com/cloudfoundry-incubator/spiff"
    system "gocart", "install"
    system "go", "install", "github.com/cloudfoundry-incubator/spiff"

    cd buildpath
    bin.install "bin/spiff"
  end

  test do
    system "#{bin}/spiff", "--version"
  end
end
