# bw

`bw` is a native MoonBit CLI module for Cloudflare Browser Rendering. It renders pages, extracts structured data, captures files, and manages asynchronous crawl jobs through a single executable.

See the complete package-local command reference in [src/README.mbt.md](src/README.mbt.md).

## Usage

Set the Cloudflare credentials in the environment, then inspect the available commands or run a command from the repository:

```bash
export CLOUDFLARE_ACCOUNT_ID=your-account-id
export CLOUDFLARE_API_TOKEN=your-api-token
moon run ./src --target native -- --help
moon run ./src --target native -- markdown --url https://example.com
```

Use `--config <path>` to select a JSON configuration file. Without an explicit path, `bw` loads `bw-config.json` from the current directory when it exists. Values are resolved in this order: command-line option, environment variable, config-file key, and option default.

## Key features

- Native MoonBit executable for the Cloudflare Browser Rendering API.
- Render HTML as Markdown, extract CSS-selected elements, retrieve links, and capture screenshots, snapshots, or PDFs.
- Extract structured JSON with an optional JSON Schema and Markdown or text output formatting.
- Manage asynchronous crawl jobs with `crawl start`, `crawl status`, and `crawl results`.
- Resolve CLI, environment, and JSON configuration values through Admiral's typed configuration loader.

## Prerequisites

- **Cloudflare**: A Cloudflare account with Browser Rendering enabled, an account ID, and an API token with permission to call the Browser Rendering API.
- **MoonBit**: The MoonBit toolchain with native target support, or Nix with flakes enabled to enter the repository's development shell.
- **Network**: Outbound access to `api.cloudflare.com` when a command calls the service.

## Setup

1. Clone the repository and enter it.

```bash
git clone https://github.com/totto2727-org/bw.git
cd bw
```

2. Enter the pinned development shell.

```bash
nix develop
```

3. Verify the executable and inspect its generated help.

```bash
moon run ./src --target native -- --help
```

## API

`bw` is an executable, so its public API is the CLI command and option surface. See the [detailed package CLI reference](src/README.mbt.md#api) for every command, option, environment variable, configuration key, and output field.

## Development

For repository structure, development commands, architecture, and contribution rules, see [AGENTS.md](./AGENTS.md).

## License

MIT. See [LICENSE](./LICENSE).

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
