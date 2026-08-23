# bw

`bw` is a native MoonBit CLI module for Cloudflare Browser Rendering. It renders pages, extracts structured data, captures files, and manages asynchronous crawl jobs through a single executable.

See the complete [CLI reference](docs/cli-reference.md).

## Usage

Set the Cloudflare credentials in the environment, then run the installed executable:

```bash
export CLOUDFLARE_ACCOUNT_ID=your-account-id
export CLOUDFLARE_API_TOKEN=your-api-token
```

```console
$ bw --help
Usage: bw [options] [command]
$ bw markdown --url https://example.com --output page.md
```

`bw --help` prints the available commands. A command such as `bw markdown --url https://example.com --output page.md` requests rendered Markdown and writes the response to `page.md`.

## Key features

- Native MoonBit executable for the Cloudflare Browser Rendering API.
- Render HTML as Markdown, extract CSS-selected elements, retrieve links, and capture screenshots, snapshots, or PDFs.
- Extract structured JSON with an optional JSON Schema and Markdown or text output formatting.
- Manage asynchronous crawl jobs with `crawl start`, `crawl status`, and `crawl results`.
- Resolve CLI, environment, and JSON configuration values through Admiral's typed configuration loader.

## Prerequisites

- **Cloudflare**: A Cloudflare account with Browser Rendering enabled, an account ID, and an API token with permission to call the Browser Rendering API.
- **Nix**: Required for the documented profile installation command.
- **Network**: Outbound access to `api.cloudflare.com` when a command calls the service.

## Setup

Install the native package with Nix:

```bash
nix profile add github:totto2727-org/bw#bw
```

## API

`bw` is an executable, so its public API is the CLI command and option surface. See the [CLI reference](docs/cli-reference.md#api) for every command, option, environment variable, configuration key, and output field.

## Development

For repository structure, development commands, architecture, and contribution rules, see [AGENTS.md](./AGENTS.md).

## License

MIT. See [LICENSE](./LICENSE).

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
