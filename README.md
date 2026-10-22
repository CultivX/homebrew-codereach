# CodeReach

Homebrew tap for [CodeReach](https://codereach.cultivx.com.au), the CLI that
drives a local [OpenCode](https://opencode.ai) session from your phone.

## Not yet

**There is no formula here yet, and `brew install` will say so.**

The CLI is distributed through npm today:

```bash
npx @cultivx/codereach
npm install -g @cultivx/codereach
```

A Homebrew formula would ship the standalone binary instead, which needs no
Node. That binary is built for every release (four platforms, with
checksums), but it is published to a release of a private repository, and the
public cannot download it — a formula cannot point at something nobody else
can fetch.

The formula is generated rather than written by hand: `bin/update-formula.sh`
reads the latest release, downloads the four platform tarballs, and writes
the formula with their SHA-256s. It is ready for the day the binaries have a
public home.

## Notes

CodeReach is not affiliated with or endorsed by the OpenCode project.
