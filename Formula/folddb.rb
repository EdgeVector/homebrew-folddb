class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.3.9"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.9/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "2b2d516a2fe23358aa2139a416e96ff6c4aedeaa711bbd7118dd26221e1affdd"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.9/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "49cf7ff36f1430e5c0493b801f57df9cd72c50527b2f5593d4e0aa26e7d1edc9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.9/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec9d165fd6909f47b975b323fd2f0c1d4072c75d92b86d75c1c0668c858a1d47"
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
