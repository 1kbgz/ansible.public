# ansible.public

## Vars

- `ANSIBLE_PRIMARY_USER`: username of primary ansible owner
- `ROOT_DOMAIN`: base domain

## Tailscale

Set `tailscale_prefer_local_routes: true` on Linux clients that accept subnet
routes and also join those networks directly. The role enables a systemd
service that checks the main IPv4 routing table before Tailscale's table,
excluding the main table's default route. Connected networks use the local
interface; destinations without a specific local route continue through
Tailscale's routing rules.

## Forgejo

The `forgejo` role installs a pinned, checksummed Forgejo LTS binary, SQLite
configuration, systemd service, and initial administrator. The role listens on
loopback by default and requires callers to provide secret material and any
network exposure policy. `FORGEJO_LFS_MAX_FILE_SIZE` sets maximum LFS object
size in bytes and defaults to 100 MiB.

The `forgejo_runner` role installs a pinned, checksummed Actions runner using a
dedicated account and rootless Podman. Callers provide offline registration
credentials, labels, and host-specific resource limits. Job containers cannot
use privileged mode, host mounts, or the runner's Podman socket.

## launchd jobs

The `launchd_jobs` role installs and loads scheduled per-user jobs on macOS.
Callers provide labels, argument arrays, calendar intervals, and log paths;
host-specific scripts and paths remain in the consuming inventory.

## code-server

The `code_server` role installs code-server with Homebrew on macOS or a pinned,
checksummed package on Debian-family Linux, writes its user configuration with
mode `0600`, and manages its Homebrew LaunchAgent or systemd instance.
`CODE_SERVER_VERSION` and `CODE_SERVER_PACKAGES` select Linux artifacts.
`CODE_SERVER_USER`, `CODE_SERVER_GROUP`, `CODE_SERVER_HOME`,
`CODE_SERVER_CONFIG_DIRECTORY`, and `CODE_SERVER_CONFIG_PATH` select the service
identity and configuration. `CODE_SERVER_BIND_ADDR`, `CODE_SERVER_AUTH`,
`CODE_SERVER_PASSWORD`, `CODE_SERVER_CERT`, and `CODE_SERVER_SERVICE_ENABLED`
control the server.

## Neovim

The `neovim` role installs Neovim with Homebrew on macOS or as a pinned,
checksummed upstream binary on AMD64 and ARM64 Debian-family Linux.
`NEOVIM_VERSION`, `NEOVIM_PACKAGES`, `NEOVIM_INSTALL_DIRECTORY`, and
`NEOVIM_BINARY` control the Linux installation. `NEOVIM_FONT_FILES` optionally
supplies controller-local font files and licenses to copy into
`NEOVIM_FONT_DIRECTORY`, which defaults to the user's `Library/Fonts` on macOS
or `/usr/local/share/fonts/neovim` on Linux. The role refreshes Linux's font
cache after copying files; terminal font selection remains a user preference.

## AI CLIs

The `ai_cli` role installs Claude Code and OpenCode on AMD64 and ARM64
Debian-family Linux. Claude Code uses [Anthropic's signed apt repository](https://code.claude.com/docs/en/setup#install-with-linux-package-managers),
selected by `CLAUDE_CODE_CHANNEL` (default `latest`). OpenCode uses the native
binary from its official npm package, pinned by `OPENCODE_VERSION` and verified
against `OPENCODE_CHECKSUMS`. AMD64 hosts without AVX2 receive the baseline
build. Both commands are available system-wide.

The role migrates a legacy `/usr/bin/claude` global npm launcher to apt.
User configuration, subscription logins, and desktop apps are managed
separately. Claude Code updates through apt; OpenCode updates require changing
the version and checksums together.

## Pi coding agent

The `pi` role installs pinned, checksummed standalone Pi releases on macOS and
AMD64 or ARM64 Debian-family Linux. The AMD64 binary targets baseline CPUs.
`PI_VERSION`, `PI_CHECKSUMS`, `PI_INSTALL_DIRECTORY`, and `PI_BINARY` control the
installation. The role checks out the Claude Code subscription provider at
`PI_CLAUDE_CODE_REVISION` inside the installation directory. User preferences,
extensions, and credentials are managed separately.

## Backup monitoring

The `backup_monitor` role adds systemd failure hooks and hourly freshness checks
to existing backup services. It sends deduplicated SMTP alerts when a service
fails or its expected backup artifact becomes stale. Callers provide backup
paths, age thresholds, recipients, and SMTP credentials.
