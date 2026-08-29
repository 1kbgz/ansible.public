# ansible.public

## Vars

- `ANSIBLE_PRIMARY_USER`: username of primary ansible owner
- `ROOT_DOMAIN`: base domain

## Forgejo

The `forgejo` role installs a pinned, checksummed Forgejo LTS binary, SQLite
configuration, systemd service, and initial administrator. The role listens on
loopback by default and requires callers to provide secret material and any
network exposure policy.
