class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  # Explicit version is required because Homebrew's URL version scanner
  # misparses the Linux tarball filename (`folddb-x86_64-unknown-linux-gnu.tar.gz`)
  # and extracts `64-unknown-linux-gnu` as the version — landing the Cellar at
  # `Cellar/folddb/64-unknown-linux-gnu/` instead of `Cellar/folddb/0.3.6/`.
  # On macOS the scanner produces `0.3.6` correctly from the `/v0.3.6/` path
  # segment, so `brew audit --strict` reports this as redundant there — accept
  # that warning: the alternative (wrong Linux Cellar path) is worse.
  version "0.3.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.6/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "7186e24171c5fe3391ef54a1b3ee229105ffd1d0c5c315b37ab94c2d0e23f927"
    else
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.6/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "ad59c4a24a5716f296ca2efc612800d712f64f2b6212d79ddf2d7e13ad0b5783"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/fold_db/releases/download/v0.3.6/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b3837ff908f923ae8a01213c7650ae0d711c0c1e1e2d338a532a9117ccf1b61"
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
