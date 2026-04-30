class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.14"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.14/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "9e25d31322f7b009f2b85e142805844b805ddf8eedd09eec21fd72fe9008633d"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.14/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "5ef3c2254c05c8cfc0d910c0d51b42f35b67bb4313774d1f87fe88092c4af83d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.14/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4efd991db43f22e2d8d6ff18d5180bc373c7d639854d71aed6b848e812bd31ba"
    end
  end

  def install
    bin.install "folddb"
    bin.install "folddb_server"
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
