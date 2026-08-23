# bw repository instructions

## Repository structure

```text
src/main.mbt                    CLI entry point and command registration
src/config.mbt                  Global options and JSON configuration loader
src/command_*.mbt               Cloudflare Browser Rendering command implementations
src/*_wbtest.mbt                MoonBit unit and integration tests
src/moon.pkg                    Native executable package definition
moon.mod                        Module metadata and registry dependencies
flake.nix                       Nix development shell, package, and overlay
package.nix                     Nix package builder
.github/workflows/              MoonBit checks and package publication workflows
README.mbt.md                   Canonical root module and CLI overview
README.md                       Relative symlink to README.mbt.md
docs/cli-reference.md           Detailed CLI command and option reference
```

## Development commands

### Execution rules

- Run commands from the repository root.
- Enter `nix develop` before running MoonBit or Nix package tasks when the pinned toolchain is required.
- Keep Cloudflare credentials in environment variables or local config files; never commit secrets.
- Keep the root module overview canonical in `README.mbt.md` with the relative `README.md -> README.mbt.md` symlink.
- Keep the detailed CLI reference in `docs/cli-reference.md`; do not duplicate it in a package README.
- Do not create a separate `CLAUDE.md` file or alias for this repository.

### Standard tasks

- `nix develop` — Enter the pinned MoonBit development shell.
- `moon info` — Inspect module and package metadata.
- `moon check` — Type-check the native MoonBit module.
- `moon test` — Run the MoonBit test suite.
- `moon build` — Build the module for its preferred native target.
- `moon package --list` — List package files and module metadata.
- `nix build` — Build the installable `bw` Nix package.
- `nix flake check --all-systems --no-build` — Evaluate flake outputs for supported systems without building them.
- `git diff --check` — Check changed files for whitespace errors.

## Architecture

### CLI entry point

- `src/main.mbt` constructs the Admiral application, registers the global `--config` option, and attaches the `content`, `markdown`, `screenshot`, `snapshot`, `pdf`, `scrape`, `json`, `links`, and `crawl` command definitions.
- Each `src/command_*.mbt` file owns its command options, request model, JSON encoding or decoding, and Cloudflare request execution.

### Configuration and HTTP boundary

- `src/config.mbt` loads the optional `bw-config.json` object and enforces CLI, environment, config, and default precedence through Admiral.
- `src/http_client.mbt` builds the Cloudflare Browser Rendering endpoint, sends authenticated requests, and raises on non-2xx responses.
- Local HTML and JSON Schema files are read at the command boundary; request bodies contain their contents rather than their paths.

### Output and tests

- `src/output.mbt` owns stdout, text-file, binary-file, and snapshot output behavior.
- `src/*_wbtest.mbt` covers configuration loading, JSON formatting, snapshot decoding, and output files without requiring live Cloudflare requests.

### Packaging and CI

- `moon.mod` declares the native-only target, module metadata, and Mooncakes dependencies.
- `package.nix` builds the module through the MoonBit platform builder, while `flake.nix` exposes the development shell, package, and overlay for macOS arm64 and Linux x86_64.
- GitHub Actions use shared setup/check/publish actions; keep workflow changes separate from documentation changes unless a task explicitly requires them.

## Development tools

- **MoonBit**: Provides the native compiler, checker, test runner, and package commands.
- **Admiral**: Parses typed CLI options, configuration values, help, and version output.
- **Lens**: Encodes and decodes Cloudflare JSON request and response models.
- **Nix flakes**: Pin the development shell and installable package inputs.
- **Mooncakes**: Supplies the published MoonBit dependencies declared in `moon.mod`.

## Package-specific rules

- Keep the README command and option reference complete when adding or changing a command; this executable has no separate public library API.
- Preserve the native target declaration and the Cloudflare API endpoint contract unless a deliberate compatibility change is documented in the README and tests.
- Add or update `*_wbtest.mbt` coverage for deterministic configuration, serialization, parsing, or output changes; do not make tests depend on live Cloudflare credentials.
- Keep the module overview, installed usage, and CLI guide link in the root `README.mbt.md`; keep the complete command and option reference in `docs/cli-reference.md`.
- Keep build, test, CI, architecture, and contributor guidance here.
- Keep the share-artifact provenance footer in the canonical root README and do not add an independently authored README or CLAUDE document.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
