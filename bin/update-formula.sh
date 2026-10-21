#!/usr/bin/env bash
# Rewrite the formula for the latest CodeReach release.
#
# The formula is generated rather than edited, so a new release is a matter of
# running this: the version comes from the release tag and the checksums come
# from the tarballs themselves.
set -euo pipefail

REPO="CultivX/codereach"
FORMULA="Formula/codereach.rb"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

tag="${1:-}"
if [ -z "$tag" ]; then
  tag="$(gh api "repos/${REPO}/releases/latest" --jq .tag_name)"
fi
version="${tag#agent-v}"
if [ "$version" = "$tag" ]; then
  echo "not a CodeReach release tag: $tag" >&2
  exit 1
fi

echo "Updating the formula to $version ($tag)"

sha_for() {
  platform="$1"
  file="codereach-${version}-${platform}.tar.gz"
  url="https://github.com/${REPO}/releases/download/${tag}/${file}"
  curl -fsSL "$url" -o "$WORK/$file"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$WORK/$file" | awk '{print $1}'
  else
    shasum -a 256 "$WORK/$file" | awk '{print $1}'
  fi
}

darwin_arm64="$(sha_for darwin-arm64)"
darwin_x64="$(sha_for darwin-x64)"
linux_arm64="$(sha_for linux-arm64)"
linux_x64="$(sha_for linux-x64)"

cat >"$FORMULA" <<RUBY
class Codereach < Formula
  desc "Drive a local OpenCode session from your phone"
  homepage "https://codereach.cultivx.com.au"
  license "MIT"
  version "${version}"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-darwin-arm64.tar.gz"
      sha256 "${darwin_arm64}"
    else
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-darwin-x64.tar.gz"
      sha256 "${darwin_x64}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-linux-arm64.tar.gz"
      sha256 "${linux_arm64}"
    else
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-linux-x64.tar.gz"
      sha256 "${linux_x64}"
    end
  end

  # The CLI drives a local OpenCode server. Homebrew installs one if there is
  # not already an \`opencode\` on the PATH; a copy installed another way (npm,
  # the OpenCode install script) is used in preference to this one.
  depends_on "opencode"

  def install
    bin.install "codereach"
  end

  test do
    assert_match "Drive a local OpenCode session", shell_output("\#{bin}/codereach --help")
  end
end
RUBY

echo "Wrote $FORMULA"
