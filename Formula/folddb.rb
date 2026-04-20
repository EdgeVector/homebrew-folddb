class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.7/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "80bae9db4eeb244c927dab852721182ed3f880f4932839336683900d0eef467f"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.7/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "453aea35bab4d8e21ff453e85e9f1233488bd0e12117b976837c57c948430f3e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.7/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "015c0c83579eac7cfffc09c406ece7d0068833bfa02d38c68fc0387a4baa30e5"
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
