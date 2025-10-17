# Homebrew Tap Setup Checklist

## For Each New Release (e.g., v0.2.0)

### In Main Project (`swift-commit-gen`)

- [ ] Make your code changes
- [ ] Update version numbers if needed
- [ ] Commit and push changes
- [ ] Create and push a new tag:
  ```bash
  git tag v0.2.0
  git push origin v0.2.0
  ```
- [ ] Verify the release appears on GitHub

### In Tap Repository (`homebrew-swift-commit-gen`)

- [ ] Update the formula using the helper script:
  ```bash
  ./update-formula.sh 0.2.0
  ```
  
  Or manually:
  - [ ] Update `url` to point to new version
  - [ ] Calculate new SHA256 hash
  - [ ] Update `sha256` in formula

- [ ] Review changes:
  ```bash
  git diff swiftcommitgen.rb
  ```

- [ ] Test the updated formula:
  ```bash
  brew uninstall swiftcommitgen  # if installed
  brew install --build-from-source ./swiftcommitgen.rb
  brew test swiftcommitgen
  swiftcommitgen --help
  ```

- [ ] Audit the formula:
  ```bash
  brew audit --strict --online swiftcommitgen
  ```

- [ ] Commit and push:
  ```bash
  git add swiftcommitgen.rb
  git commit -m "Update swiftcommitgen to 0.2.0"
  git push origin main
  ```

- [ ] Verify users can upgrade:
  ```bash
  brew upgrade swiftcommitgen
  ```

## Troubleshooting

### Formula not found
- Ensure repo name starts with `homebrew-`
- Try: `brew untap Iron-Ham/swift-commit-gen && brew tap Iron-Ham/swift-commit-gen`

### Build failures
- Check Xcode version requirement
- Verify macOS version requirement
- Test with: `brew install --build-from-source --verbose swiftcommitgen`

### SHA256 mismatch
- Wait a few minutes after creating the tag (GitHub needs to generate the archive)
- Recalculate: `curl -L <url> 2>/dev/null | shasum -a 256`
- Clear Homebrew cache: `brew cleanup -s swiftcommitgen`

### Testing specific versions
```bash
# Install a specific version
brew install Iron-Ham/swift-commit-gen/swiftcommitgen@0.1.0

# Install from HEAD (latest main branch)
brew install --HEAD swiftcommitgen
```
