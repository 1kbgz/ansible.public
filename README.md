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
