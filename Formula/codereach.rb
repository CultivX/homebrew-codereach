class Codereach < Formula
  desc "Drive a local OpenCode session from your phone"
  homepage "https://codereach.cultivx.com.au"
  license "MIT"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-darwin-x64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/CultivX/codereach/releases/download/agent-v#{version}/codereach-#{version}-linux-x64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  # The CLI drives a local OpenCode server. Homebrew installs one if there is
  # not already an `opencode` on the PATH; a copy installed another way (npm,
  # the OpenCode install script) is used in preference to this one.
  depends_on "opencode"

  def install
    bin.install "codereach"
  end

  test do
    assert_match "Drive a local OpenCode session", shell_output("#{bin}/codereach --help")
  end
end
