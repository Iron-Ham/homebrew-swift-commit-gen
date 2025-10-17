#!/bin/bash
set -euo pipefail

# Helper script to update the Homebrew formula for a new release
# Usage: ./update-formula.sh <version>
# Example: ./update-formula.sh 0.2.0

if [ $# -eq 0 ]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 0.2.0"
  exit 1
fi

VERSION=$1
REPO="Iron-Ham/swift-commit-gen"
FORMULA_FILE="swiftcommitgen.rb"

# Construct the URL
URL="https://github.com/${REPO}/archive/refs/tags/${VERSION}.tar.gz"

echo "Calculating SHA256 for version ${VERSION}..."
SHA256=$(curl -L "${URL}" 2>/dev/null | shasum -a 256 | awk '{print $1}')

if [ -z "$SHA256" ]; then
  echo "Error: Failed to calculate SHA256. Is the release tag v${VERSION} published?"
  exit 1
fi

echo "SHA256: ${SHA256}"
echo ""
echo "Updating ${FORMULA_FILE}..."

# Update the formula file
# This uses sed to replace the url and sha256 lines
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS sed
  sed -i '' "s|url \".*\"|url \"${URL}\"|" "${FORMULA_FILE}"
  sed -i '' "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "${FORMULA_FILE}"
else
  # Linux sed
  sed -i "s|url \".*\"|url \"${URL}\"|" "${FORMULA_FILE}"
  sed -i "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "${FORMULA_FILE}"
fi

echo "✅ Formula updated successfully!"
echo ""
echo "Version: ${VERSION}"
echo "URL: ${URL}"
echo "SHA256: ${SHA256}"
echo ""
echo "Next steps:"
echo "1. Review the changes: git diff ${FORMULA_FILE}"
echo "2. Test the formula: brew install --build-from-source ./${FORMULA_FILE}"
echo "3. Audit: brew audit --strict --online swiftcommitgen"
echo "4. Commit: git add ${FORMULA_FILE} && git commit -m 'Update swiftcommitgen to ${VERSION}'"
echo "5. Push: git push origin main"
