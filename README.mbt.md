# bw

`bw` is a native MoonBit CLI module for Cloudflare Browser Rendering. It renders pages, extracts structured data, captures files, and manages asynchronous crawl jobs through a single executable.

For every command, option, environment variable, and configuration key, see the [detailed CLI reference](src/README.mbt.md#api).

## Usage

Set the Cloudflare credentials in the environment, then inspect the available commands or run the installed CLI:

```bash
export CLOUDFLARE_ACCOUNT_ID=your-account-id
export CLOUDFLARE_API_TOKEN=your-api-token
bw --help
bw markdown --url https://example.com
bw markdown --url https://example.com --output markdown-response.json
bw crawl start --url https://example.com --format markdown
bw crawl status --id crawl-job-id
```

`bw --help` prints the generated command list. Without `--output`, `bw markdown` prints the Cloudflare JSON response envelope to stdout; with `--output`, it writes that envelope to the named file and prints a confirmation. `bw crawl start` prints a response whose `result` is the crawl job ID; pass that ID to `bw crawl status` to print the current status response.

Use `--config <path>` to select a JSON configuration file. Without an explicit path, `bw` loads `bw-config.json` from the current directory when it exists. Values are resolved in this order: command-line option, environment variable, config-file key, and option default.

## Key features

- Native MoonBit executable for the Cloudflare Browser Rendering API.
- Render HTML as Markdown, extract CSS-selected elements, retrieve links, and capture screenshots, snapshots, or PDFs.
- Extract structured JSON with an optional JSON Schema and Markdown or text output formatting.
- Manage asynchronous crawl jobs with `crawl start`, `crawl status`, and `crawl results`.
- Resolve CLI, environment, and JSON configuration values through Admiral's typed configuration loader.

## Prerequisites

- **Cloudflare**: A Cloudflare account with Browser Rendering enabled, an account ID, and an API token with permission to call the Browser Rendering API.
- **Nix**: Install Nix with flakes enabled to install `bw` from its flake.
- **Network**: Outbound access to `api.cloudflare.com` when a command calls the service.

## Setup

1. Install `bw` into your Nix profile.

```bash
nix profile install github:totto2727-org/bw
```

## API

`bw` is an executable, so its public API is the CLI command and option surface. See the [detailed package CLI reference](src/README.mbt.md#api) for every command, option, environment variable, configuration key, and output field.

## Development

For repository structure, development commands, architecture, and contribution rules, see [AGENTS.md](./AGENTS.md).

## License

MIT. See [LICENSE](./LICENSE).

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
