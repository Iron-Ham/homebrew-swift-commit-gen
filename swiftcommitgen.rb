class Swiftcommitgen < Formula
  desc "AI-powered Git commit message generator using Apple Intelligence"
  homepage "https://github.com/Iron-Ham/swift-commit-gen"
  url "https://github.com/Iron-Ham/swift-commit-gen/archive/refs/tags/0.1.1.tar.gz"
  sha256 "c3cf9957dc2808fcb4120e5b488b78373edf9b4105b585c229a7fe1ebd3b331b"
  license "MIT"
  head "https://github.com/Iron-Ham/swift-commit-gen.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on macos: :tahoe

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/swiftcommitgen"
  end

  def caveats
    <<~EOS
      SwiftCommitGen requires macOS Tahoe (26.0+) with Apple Intelligence enabled.

      First-Run Setup:
      - Enable Apple Intelligence in System Settings → Apple Intelligence & Siri
      - Grant Full Disk Access to your Terminal in System Settings → Privacy & Security
      - The first run may prompt for Apple Intelligence permissions

      Usage:
        cd your-git-repo
        swiftcommitgen generate

      Options:
        --staged     Analyze only staged changes
        --commit     Auto-commit after accepting the message
        --format     Output format (text or json)
        --help       Show all available options
    EOS
  end

  test do
    assert_match "USAGE: swiftcommitgen", shell_output("#{bin}/swiftcommitgen --help")
  end
end
