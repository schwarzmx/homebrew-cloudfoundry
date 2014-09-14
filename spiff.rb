require "formula"

class Spiff < Formula
  homepage "https://github.com/cloudfoundry-incubator/spiff"
  url "https://github.com/cloudfoundry-incubator/spiff.git", :tag => "v1.0.3"

  head "https://github.com/cloudfoundry-incubator/spiff.git", :branch => "master"

  depends_on "go" => :build
  depends_on "godep" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/cloudfoundry-incubator/spiff"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/cloudfoundry-incubator/spiff"

    system "godep", "go", "build", "-o", "out/spiff", "github.com/cloudfoundry-incubator/spiff"

    bin.install "out/spiff"
  end

  test do
    system "#{bin}/spiff", "--version"
  end
end
