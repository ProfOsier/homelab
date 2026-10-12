# OpenObserve operations

## Verified installation

- UI: https://logs.osier.local/
- Container: `openobserve`, image `public.ecr.aws/zinclabs/openobserve:latest`.
- Data: `/mnt/truenas/openobserve:/data`.
- Networks: existing external `monitoring` and `proxy`; no host HTTP port is published.
- Nginx Proxy Manager forwards logs.osier.local to openobserve:5080 over HTTP on the proxy network. Retain the existing working proxy and TLS settings.
- Alloy currently reads Ubuntu syslog/auth files and Docker JSON logs. It listens on UDP 1514 for OPNsense and UDP 1515 for Omada and writes to `http://openobserve:5080/api/default/loki/api/v1/push` using Basic authentication.

## Credentials

Merge the new variables from the root `.env.example` into the existing root `.env`. Do not copy the example over the populated file. Preserve the installed root account and the ingestion credentials from the running Alloy configuration. Store them only locally; never commit the populated .env or collector files containing literal credentials. Use mode 0600 for .env.

The root login variables are `ZO_ROOT_USER_EMAIL` and `ZO_ROOT_USER_PASSWORD`. Alloy receives `OPENOBSERVE_LOKI_URL`, `OPENOBSERVE_INGEST_USER`, and `OPENOBSERVE_INGEST_PASSWORD` through Compose. Changing bootstrap variables is not a supported way to reset an existing user's password.

## Existing local changes

The server has uncommitted Compose edits and an untracked `config/monitoring/alloy` directory. Back up both outside the repository before merging. Existing local Alloy filenames overlap with the new tracked templates; preserve the current contents and merge deliberately rather than overwriting them. Keep additional local collectors. Replace the writer's literal credentials with the environment references only after the environment is populated.

The Compose addition retains the verified data mount and existing default data-directory behavior. Do not introduce a new `ZO_DATA_DIR` or change the storage directory without checking the installed data layout. Preserve the current images during reconciliation; a later pull of `latest` is an upgrade and should be handled separately.

## Deployment

OpenObserve and Alloy are already running. Repository changes alone do not require a restart. Before applying a change, review the diff against the active files and validate locally:

```bash
docker compose config --quiet
docker exec alloy alloy validate --stability.level=experimental /etc/alloy
```

When credential references or Compose configuration actually change, recreate only those services:

```bash
docker compose up -d --no-deps --pull never openobserve alloy
docker compose ps openobserve alloy
docker logs --tail 50 alloy
curl --fail --silent --show-error https://logs.osier.local/healthz
```

Do not run the old blanket migration helpers or deploy the whole historical stack for this change. Existing Grafana, Loki, Promtail, and Prometheus configurations are retained; do not remove containers or data as part of adding OpenObserve. The `loki.*` component names in Alloy identify the ingestion protocol, not a requirement to run a Loki server.

## TrueNAS opnsense-syslog

A TrueNAS application called `opnsense-syslog` exists, but its forwarding destination has not been verified. If it sends directly to OpenObserve, the Alloy OPNsense input may overlap. Trace OPNsense's configured syslog destination and the TrueNAS app's output before disabling either path. Alloy still handles Docker, Ubuntu, and Omada logs. Avoid sending the same firewall events twice; confirm hostname, source, and timestamps in OpenObserve before changing routing.

## Homepage and Nessus

Homepage keeps the OpenObserve tile and Docker CPU/memory/cumulative RX/TX data. Its integration needs no OpenObserve root password. Nessus is removed from Homepage because the trial ended; no Nessus service definition was found in the active tracked Compose files. No scan data, certificates, or container volumes are deleted. NetAlertX continues to populate the Security section through Docker labels.

## Backups and recovery

Repository backups preserve configuration but do not include the NAS OpenObserve data mount. Back up `/mnt/truenas/openobserve` separately using a consistent snapshot or a stopped-service backup. Preserve metadata, stream data, and WAL together. Retain local .env separately and securely. To roll back configuration, restore the backed-up Compose and Alloy files and recreate only affected services without pulling images. Never remove the OpenObserve data directory or use `down -v` for a configuration rollback.

## References

- https://openobserve.ai/docs/reference/api/ingestion/logs/loki/
- https://openobserve.ai/docs/administration/configuration/environment-variables/
- https://grafana.com/docs/alloy/latest/reference/components/loki/loki.write/
