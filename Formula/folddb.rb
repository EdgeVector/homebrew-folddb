class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.0/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "cf4224b2a49d00560b77543352886552b2daa6c1bc2209e615a748e9da859303"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.0/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "e21985b9fa6a443f8a1b9e7b7d1024be825544033b1f562c27d27f0b208b97a4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.0/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce92303379fb852b97f5bdd33dce8e5bdf2c4646b5aa4ef72db84861c9f0e428"
    end
  end

  def install
    bin.install "folddb"
    bin.install "folddb_server" if File.exist?("folddb_server")
    bin.install "schema_service" if File.exist?("schema_service")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/folddb --version")
  end
end
