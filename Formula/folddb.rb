class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v#{version}/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "75f9e6b07b89b2d727d7b4bab15cb997d63ffe10fb2b79984ce4550ba15d9e53"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v#{version}/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "c6729d644d7a310667deb93dcc0329a36f45eba8a1fc06fcc5c9e14463f4bdd1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v#{version}/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "58cc3edc07fbeedbf3c59fa88866491d669599b89cee7a983a15671c912ed4b5"
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
        http://localhost:9101

      Second-device bootstrap (restore from BIP39 recovery phrase):
        https://github.com/EdgeVector/fold_db_node/blob/main/docs/dogfood/second-device.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/folddb --version")
  end
end
