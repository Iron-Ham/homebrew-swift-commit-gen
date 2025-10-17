# Homebrew Tap for SwiftCommitGen

Official Homebrew tap for [SwiftCommitGen](https://github.com/Iron-Ham/swift-commit-gen) - an AI-powered Git commit message generator using Apple Intelligence.

## For Users

### Installation

```bash
brew tap Iron-Ham/swift-commit-gen
brew install swiftcommitgen
```

Or install directly without tapping:

```bash
brew install Iron-Ham/swift-commit-gen/swiftcommitgen
```

### Development Version

To install from the latest `main` branch:

```bash
brew install --HEAD Iron-Ham/swift-commit-gen/swiftcommitgen
```

### Updating

```bash
brew upgrade swiftcommitgen
```

### Requirements

- macOS Tahoe (26.0) or later
- Xcode 26.0 or later
- Apple Intelligence enabled

## For Maintainers

### Release Process

When a new version is released in the main repository:

1. **In the main repo** (`Iron-Ham/swift-commit-gen`):
   ```bash
   git tag v0.2.0
   git push origin v0.2.0
   ```

2. **In this tap repo**, update the formula:
   ```bash
   # Use the helper script
   ./update-formula.sh 0.2.0
   
   # Or manually:
   # 1. Update the version in swiftcommitgen.rb
   # 2. Calculate SHA256:
   curl -L https://github.com/Iron-Ham/swift-commit-gen/archive/refs/tags/v0.2.0.tar.gz 2>/dev/null | shasum -a 256
   # 3. Update sha256 in swiftcommitgen.rb
   ```

3. **Commit and push**:
   ```bash
   git add swiftcommitgen.rb
   git commit -m "Update swiftcommitgen to 0.2.0"
   git push origin main
   ```

4. **Users automatically get the update** when they run `brew upgrade`

### Testing the Formula

Before pushing changes:

```bash
# Audit the formula for issues
brew audit --strict --online swiftcommitgen

# Test installation from source
brew uninstall swiftcommitgen  # if already installed
brew install --build-from-source swiftcommitgen

# Run the formula's test
brew test swiftcommitgen

# Verify it works
swiftcommitgen --help
```

### Testing Locally (Without Publishing)

```bash
# Install from local formula file
brew install --build-from-source ./swiftcommitgen.rb

# Or test with a specific commit
brew install --HEAD --build-from-source ./swiftcommitgen.rb
```

### Repository Structure

```
homebrew-swift-commit-gen/
├── swiftcommitgen.rb      # The formula
├── update-formula.sh      # Helper script for updates
└── README.md              # This file
```

**Note:** Homebrew expects the formula in the root directory for taps, not in a `Formula/` subdirectory (though both work).
