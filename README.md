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

The `code_server` role installs code-server with Homebrew on macOS, writes its
user configuration with mode `0600`, and manages its Homebrew LaunchAgent.
`CODE_SERVER_BIND_ADDR`, `CODE_SERVER_AUTH`, `CODE_SERVER_PASSWORD`,
`CODE_SERVER_CERT`, and `CODE_SERVER_SERVICE_ENABLED` control the deployment.

## Backup monitoring

The `backup_monitor` role adds systemd failure hooks and hourly freshness checks
to existing backup services. It sends deduplicated SMTP alerts when a service
fails or its expected backup artifact becomes stale. Callers provide backup
paths, age thresholds, recipients, and SMTP credentials.
