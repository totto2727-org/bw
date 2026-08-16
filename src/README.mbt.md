# bw

`bw` is a native MoonBit CLI for Cloudflare Browser Rendering, with commands for rendered content, Markdown, screenshots, PDFs, structured extraction, links, and asynchronous crawls.

This package-local document is canonical `README.mbt.md`; the repository-root `README.mbt.md` and `README.md` are relative symlinks to this file.

## Usage

Set the Cloudflare credentials in the environment, then run a command from the repository:

```bash
export CLOUDFLARE_ACCOUNT_ID=your-account-id
export CLOUDFLARE_API_TOKEN=your-api-token
moon run ./src --target native -- markdown --url https://example.com
```

Use a local HTML file instead of a URL with `--html`:

```bash
moon run ./src --target native -- markdown --html page.html --output page.md
moon run ./src --target native -- screenshot --url https://example.com --output page.png
moon run ./src --target native -- json --url https://example.com --prompt "Extract the title" --format text
moon run ./src --target native -- crawl start --url https://example.com --format html --format markdown
```

`--config <path>` is a global option and can appear before or after a command at any nesting depth. Without an explicit path, `bw` loads `bw-config.json` from the current directory when it exists; a missing default file is ignored, while a missing explicitly selected file is an error.

Values are resolved in this order: command-line option, environment variable, config-file key, and option default. Config keys use the independent snake_case names documented in the API section. For multiple crawl formats, use a JSON string array such as `"formats": ["html", "markdown"]` or repeat `--format`; `BW_CRAWL_FORMATS` is a scalar environment value and accepts comma-separated formats.

```mbt check
///|
test "comma-separated crawl formats" {
  let formats = "html,markdown"
    .split(",")
    .map(fn(item) { item.to_owned() })
    .collect()
  debug_inspect(formats, content="[\"html\", \"markdown\"]")
}
```

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

`bw` is an executable, so its public API is the command and option surface below. Admiral also provides `--help` and `--version` on the root command and every command path.

### Global options

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--account-id <id>` | `CLOUDFLARE_ACCOUNT_ID` | `account_id` | Cloudflare account ID; required for every API command. |
| `--api-token <token>` | `CLOUDFLARE_API_TOKEN` | `api_token` | Cloudflare API token; required for every API command. |
| `--config <path>` | — | — | JSON config path; defaults to `bw-config.json`. |
| `--help` | — | — | Show help for the current command path. |
| `--version` | — | — | Show the CLI version. |

### Shared page-source options

The `content`, `markdown`, `scrape`, `links`, `pdf`, `screenshot`, `snapshot`, `json`, and `crawl start` commands accept these options. At least one of `--url` and `--html` is required; when both are supplied, both values are included in the request body.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--url <url>` | `BW_URL` | `url` | Target URL. |
| `--html <path>` | `BW_HTML` | `html` | Path to a local HTML file. |
| `--wait-until <strategy>` | `BW_WAIT_UNTIL` | `wait_until` | Page load strategy forwarded to Browser Rendering. |

### `content`

Fetches rendered HTML. The JSON response envelope is printed to stdout unless `--output` is set.

```bash
moon run ./src --target native -- content --url https://example.com --output page.html
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the JSON response envelope to this file instead of stdout. |

### `markdown`

Extracts Markdown from a rendered page. The JSON response envelope is printed to stdout unless `--output` is set.

```bash
moon run ./src --target native -- markdown --url https://example.com --output page.md
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the JSON response envelope to this file instead of stdout. |

### `scrape`

Extracts elements matching a required CSS selector.

```bash
moon run ./src --target native -- scrape --url https://example.com --selector 'article h1'
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--selector <css>` | `BW_SELECTOR` | `selector` | CSS selector for the elements to extract; required. |

### `links`

Retrieves links from a rendered page.

```bash
moon run ./src --target native -- links --url https://example.com --visible-only --internal-only
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--visible-only` | `BW_VISIBLE_ONLY` | `visible_only` | Include only visible links. |
| `--internal-only` | `BW_INTERNAL_ONLY` | `internal_only` | Include only same-domain links. |

### `pdf`

Generates a PDF. The output path is required.

```bash
moon run ./src --target native -- pdf --url https://example.com --output page.pdf --format a4
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | PDF output path; required. |
| `--landscape` | `BW_LANDSCAPE` | `landscape` | Render in landscape orientation. |
| `--format <format>` | `BW_FORMAT` | `format` | PDF page format. |

### `screenshot`

Captures a screenshot. The output path is required.

```bash
moon run ./src --target native -- screenshot --url https://example.com --output page.png --full-page
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Screenshot output path; required. |
| `--full-page` | `BW_FULL_PAGE` | `full_page` | Capture the entire page. |
| `--width <pixels>` | `BW_WIDTH` | `width` | Viewport width. |
| `--height <pixels>` | `BW_HEIGHT` | `height` | Viewport height. |

### `snapshot`

Captures HTML and a screenshot in an output directory. The output directory is required.

```bash
moon run ./src --target native -- snapshot --url https://example.com --output snapshot
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <directory>` | `BW_OUTPUT` | `output` | Output directory; required. |
| `--full-page` | `BW_FULL_PAGE` | `full_page` | Capture the entire page. |

### `json`

Extracts structured data using a required prompt. It prints the raw Cloudflare JSON response by default; `markdown` and `text` formats print the extracted `result`.

```bash
moon run ./src --target native -- json --url https://example.com --prompt "Extract the title" --format markdown
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--prompt <text>` | `BW_PROMPT` | `prompt` | Extraction prompt; required. |
| `--schema <path>` | `BW_SCHEMA` | `schema` | Path to a JSON Schema file, sent as `response_format.schema`. |
| `--format <json|markdown|text>` | `BW_FORMAT` | `format` | Output format; defaults to raw JSON. |

### `crawl`

Manages asynchronous crawl jobs through three subcommands.

#### `crawl start`

Starts a crawl job and optionally writes the API response to `--output`.

```bash
moon run ./src --target native -- crawl start --url https://example.com --limit 20 --depth 2 --format markdown
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the start response to this file. |
| `--limit <count>` | `BW_CRAWL_LIMIT` | `limit` | Maximum pages to crawl. |
| `--depth <count>` | `BW_CRAWL_DEPTH` | `depth` | Maximum link depth. |
| `--format <html|markdown|json>` | `BW_CRAWL_FORMATS` | `formats` | Output format; repeat for multiple values or use a comma-separated environment value. |

#### `crawl status`

Checks a crawl job's status.

```bash
moon run ./src --target native -- crawl status --id crawl-job-id
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--id <id>` | `BW_CRAWL_ID` | `id` | Crawl job ID; required. |

#### `crawl results`

Retrieves the results for a crawl job from `/crawl/{id}/results`.

```bash
moon run ./src --target native -- crawl results --id crawl-job-id --output results.json
```

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--id <id>` | `BW_CRAWL_ID` | `id` | Crawl job ID; required. |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the results to this file instead of stdout. |

## Development

For repository structure, development commands, architecture, and contribution rules, see [AGENTS.md](../AGENTS.md).

## License

MIT. See [LICENSE](../LICENSE).

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
