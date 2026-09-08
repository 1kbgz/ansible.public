# ansible.public

## Vars

- `ANSIBLE_PRIMARY_USER`: username of primary ansible owner
- `ROOT_DOMAIN`: base domain

## Forgejo

The `forgejo` role installs a pinned, checksummed Forgejo LTS binary, SQLite
configuration, systemd service, and initial administrator. The role listens on
loopback by default and requires callers to provide secret material and any
network exposure policy.

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
`NEOVIM_BINARY` control the Linux installation.

## Backup monitoring

The `backup_monitor` role adds systemd failure hooks and hourly freshness checks
to existing backup services. It sends deduplicated SMTP alerts when a service
fails or its expected backup artifact becomes stale. Callers provide backup
paths, age thresholds, recipients, and SMTP credentials.
