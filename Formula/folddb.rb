class Folddb < Formula
  desc "Local-first database for personal data sovereignty"
  homepage "https://folddb.com"
  version "0.10.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/EdgeVector/homebrew-folddb/releases/download/v0.10.0/folddb-aarch64-apple-darwin.tar.gz"
      sha256 "855c20c0b354b32408602d703511f2c8a6c69bdf0e4e77cf8790a85010a6ddde"
    else
      url "https://github.com/EdgeVector/homebrew-folddb/releases/download/v0.10.0/folddb-x86_64-apple-darwin.tar.gz"
      sha256 "362024c83e598bea593a8cf952cb70e961f3183309eb7a3e8bddd3035643976b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/EdgeVector/homebrew-folddb/releases/download/v0.10.0/folddb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3848729b87698355542e59df06634492324cbe60986b2e80be4f933d2c0c4133"
    end
  end

  def install
    bin.install "folddb"
    bin.install "folddb_server"
  end

  service do
    run [opt_bin/"folddb_server", "--port", "9001"]
    keep_alive true
    run_at_load true
    log_path var/"log/folddb/folddb.log"
    error_log_path var/"log/folddb/folddb.err.log"
    environment_variables HOME: Dir.home, PATH: std_service_path_env
  end

  def caveats
    <<~EOS
      To start the FoldDB daemon:
        folddb daemon start

      Then open the dashboard at:
        http://localhost:9001

      After `brew upgrade folddb`, the already-running daemon keeps serving the
      OLD binary on port 9001 — Homebrew does not restart it for you. Restart
      it so the new version takes effect:

        brew services restart folddb                  # if started via `brew services`
        folddb daemon stop && folddb daemon start     # if you run it manually

      A restart drops the daemon's in-memory loaded schemas, so app clients
      (e.g. fbrain, fkanban) may need to re-run their `init` afterward.

      Second-device bootstrap (restore from BIP39 recovery phrase):
        https://github.com/EdgeVector/fold/blob/main/fold_db_node/docs/dogfood/second-device.md

      If you upgraded from fold_db_node < 0.5.1, your data may live at the
      literal-tilde path $HOME/~/.folddb/data instead of $HOME/.folddb/data.
      To check / migrate:
        folddb migrate-tilde-data            # dry-run
        folddb migrate-tilde-data --apply    # actually move it
      Runbook: https://github.com/EdgeVector/fold/blob/main/fold_db_node/docs/dogfood/tilde-data-migration.md
    EOS
  end

  test do
    assert_match "FoldDB CLI", shell_output("#{bin}/folddb --help")
  end
end
