class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.10/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "54b12f6c3afe5bc424c2010cfa5a6d0190a3abba253b33cc6a44abff42d1bf0c"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.10/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "a300ae9960f2227432d84141c472cdf15ed4b4a7ae8e1d0e688a12ecc2974ec0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.10/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1563ddaa01472d32eae2310892964b631c6283281a6d50bd57f747c6e9c733de"
    end
  end

  def install
    bin.install "folddb"
    bin.install "folddb_server"
    bin.install "schema_service"
  end

  def caveats
    <<~EOS
      To start the FoldDB daemon:
        folddb daemon start

      Then open the dashboard at:
        http://localhost:9001

      Second-device bootstrap (restore from BIP39 recovery phrase):
        https://github.com/EdgeVector/fold_db_node/blob/main/docs/dogfood/second-device.md
    EOS
  end

  test do
    assert_match "FoldDB CLI", shell_output("#{bin}/folddb --help")
  end
end
