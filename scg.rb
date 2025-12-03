class Scg < Formula
  desc "AI-powered Git commit message generator using Apple Intelligence"
  homepage "https://github.com/Iron-Ham/swift-commit-gen"
  url "https://github.com/Iron-Ham/swift-commit-gen/archive/refs/tags/0.4.1.tar.gz"
  sha256 "b51f336dfcfaeccd647150aa2b9bc94def709a3f46ca8d2b3b0ab4e94c700048"
  license "MIT"
  head "https://github.com/Iron-Ham/swift-commit-gen.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on macos: :tahoe

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/scg"
  end

  def caveats
    <<~EOS
      scg requires macOS Tahoe (26.0+) with Apple Intelligence enabled.

      First-Run Setup:
      - Enable Apple Intelligence in System Settings → Apple Intelligence & Siri
      - Grant Full Disk Access to your Terminal in System Settings → Privacy & Security
      - The first run may prompt for Apple Intelligence permissions

      Usage:
        cd your-git-repo
        scg generate

      Options:
        --staged     Analyze only staged changes
        --commit     Auto-commit after accepting the message
        --format     Output format (text or json)
        --help       Show all available options
    EOS
  end

  test do
    assert_match "USAGE: scg", shell_output("#{bin}/scg --help")
  end
end