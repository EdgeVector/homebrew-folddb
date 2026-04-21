class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.8/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "30cd682941feaa8bcfa5151585eb889d065b13e56913d38cb0760449d83f3e5e"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.8/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "f1fd50b742f95cb9bbfa76d50d516ffbaf31e1ced816d19706070d44d5e040a2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.8/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3f2e76ca552d97b6a6c4fb028332610476109f84937bc4a5306df66bddc81462"
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
