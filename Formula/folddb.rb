class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.13"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.13/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "c0cdc4f113b5784244491d394dda99ae8580d2bc8381123cc897ede38e1e9a9d"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.13/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "5892d651e983af56fd085c7786e3eb8204093fa5b6adc26f0bd3d70caf92afcf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.13/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "afefab4c6203994a0b5ddc8838e66604d0f893a326d0c95f6be0aa04844d3d9b"
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
