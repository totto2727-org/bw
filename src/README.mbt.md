# bw package CLI reference

This package-local README is published with the executable package and owns the complete `bw` command and option reference. The root [README.mbt.md](../README.mbt.md) owns the shared overview, usage, features, prerequisites, and setup guidance.

## API

`bw` is an executable, so its public API is the command and option surface below. `--help` is accepted at the root and nested command paths and prints help for the invoked command path; `--version` is accepted only by the root command.

### Global options

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--account-id <id>` | `CLOUDFLARE_ACCOUNT_ID` | `account_id` | Cloudflare account ID; required for every API command. |
| `--api-token <token>` | `CLOUDFLARE_API_TOKEN` | `api_token` | Cloudflare API token; required for every API command. |
| `--config <path>` | — | — | JSON config path; defaults to `bw-config.json`. |
| `--help` | — | — | Show help for the invoked root or nested command path. |
| `--version` | — | — | Show the CLI version from the root command; nested paths reject this option. |

### Shared page-source options

The `content`, `markdown`, `scrape`, `links`, `pdf`, `screenshot`, `snapshot`, `json`, and `crawl start` commands accept these options. At least one of `--url` and `--html` is required; when both are supplied, both values are included in the request body.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--url <url>` | `BW_URL` | `url` | Target URL. |
| `--html <path>` | `BW_HTML` | `html` | Path to a local HTML file. |
| `--wait-until <strategy>` | `BW_WAIT_UNTIL` | `wait_until` | Page load strategy forwarded to Browser Rendering. |

### `content`

Fetches rendered HTML. The JSON response envelope is printed to stdout unless `--output` is set.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the JSON response envelope to this file instead of stdout. |

### `markdown`

Extracts Markdown from a rendered page. The JSON response envelope is printed to stdout unless `--output` is set.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the JSON response envelope to this file instead of stdout. |

### `scrape`

Extracts elements matching a required CSS selector.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--selector <css>` | `BW_SELECTOR` | `selector` | CSS selector for the elements to extract; required. |

### `links`

Retrieves links from a rendered page.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--visible-only` | `BW_VISIBLE_ONLY` | `visible_only` | Include only visible links. |
| `--internal-only` | `BW_INTERNAL_ONLY` | `internal_only` | Include only same-domain links. |

### `pdf`

Generates a PDF. The output path is required.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | PDF output path; required. |
| `--landscape` | `BW_LANDSCAPE` | `landscape` | Render in landscape orientation. |
| `--format <format>` | `BW_FORMAT` | `format` | PDF page format. |

### `screenshot`

Captures a screenshot. The output path is required.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Screenshot output path; required. |
| `--full-page` | `BW_FULL_PAGE` | `full_page` | Capture the entire page. |
| `--width <pixels>` | `BW_WIDTH` | `width` | Viewport width. |
| `--height <pixels>` | `BW_HEIGHT` | `height` | Viewport height. |

### `snapshot`

Captures HTML and a screenshot in an output directory. The output directory is required.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <directory>` | `BW_OUTPUT` | `output` | Output directory; required. |
| `--full-page` | `BW_FULL_PAGE` | `full_page` | Capture the entire page. |

### `json`

Extracts structured data using a required prompt. It prints the raw Cloudflare JSON response by default; `markdown` and `text` formats print the extracted `result`.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--prompt <text>` | `BW_PROMPT` | `prompt` | Extraction prompt; required. |
| `--schema <path>` | `BW_SCHEMA` | `schema` | Path to a JSON Schema file, sent as `response_format.schema`. |
| `--format <json|markdown|text>` | `BW_FORMAT` | `format` | Output format; defaults to raw JSON. |

### `crawl`

Manages asynchronous crawl jobs through three subcommands.

#### `crawl start`

Starts a crawl job and optionally writes the API response to `--output`.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the start response to this file. |
| `--limit <count>` | `BW_CRAWL_LIMIT` | `limit` | Maximum pages to crawl. |
| `--depth <count>` | `BW_CRAWL_DEPTH` | `depth` | Maximum link depth. |
| `--format <html|markdown|json>` | `BW_CRAWL_FORMATS` | `formats` | Output format; repeat for multiple values or use a comma-separated environment value. |

#### `crawl status`

Checks a crawl job's status.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--id <id>` | `BW_CRAWL_ID` | `id` | Crawl job ID; required. |

#### `crawl results`

Retrieves the results for a crawl job from `/crawl/{id}/results`.

| Option | Environment variable | Config key | Description |
| --- | --- | --- | --- |
| `--id <id>` | `BW_CRAWL_ID` | `id` | Crawl job ID; required. |
| `--output`, `-o <path>` | `BW_OUTPUT` | `output` | Write the results to this file instead of stdout. |

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
