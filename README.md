# CodeReach

Homebrew tap for [CodeReach](https://codereach.cultivx.com.au), the CLI that
drives a local [OpenCode](https://opencode.ai) session from your phone.

## Install

```bash
brew install codereach/tap/codereach
```

Then run it in a project folder:

```bash
cd your-project
codereach
```

It prints a QR code. Scan it with the CodeReach app to pair your phone.

## What you get

`codereach` is the standalone binary, the same build the install script
downloads. It needs no Node, and it drives a local OpenCode server, so
[OpenCode](https://opencode.ai) is installed as a dependency. If you already
have `opencode` on your PATH (installed with npm, or with OpenCode's own
install script), that one is used instead.

## Updating

```bash
brew upgrade codereach
```

The formula is regenerated automatically when a new release is published, so
this always moves to the latest one. You can also ask the CLI itself:

```bash
codereach upgrade
```

It works out how it was installed and runs the right command.

## Other ways to install

```bash
npx codereach                                    # from npm, no install
curl -fsSL https://codereach.cultivx.com.au/install.sh | sh
```

## Notes

CodeReach is not affiliated with or endorsed by the OpenCode project.
