# Osier Homepage

Homepage configuration templates for the Osier homelab.

## Dashboard telemetry

- OpenObserve links to https://logs.osier.local/ and shows its container CPU, memory, and cumulative network RX/TX totals.
- Homepage, Portainer, Dozzle, Nginx Proxy Manager, and Uptime Kuma show Docker statistics through the existing read-only socket integration named `my-docker`.
- Portainer uses environment ID 3, verified against the live installation, and shows running/stopped/total containers. Compose maps the existing `PORTAINER_API_KEY` to `HOMEPAGE_VAR_PORTAINER_API_KEY`; the key stays outside Git.
- The live Pi-hole widget already reports DNS queries and blocked queries. Its installed v6 configuration differs from this older template; preserve the working live configuration when deploying.
- NetAlertX is discovered through Docker labels in the Security group. The manual Monitoring duplicate has been removed.
- Uptime Kuma's unconfigured status-page widget is removed; its container statistics remain. An application summary needs an existing published status-page slug.

Container RX/TX counters are totals since container start, not bandwidth rates. OpenObserve log/error counts, OPNsense WAN traffic, and TrueNAS pool health require additional verified service API integrations.

## Deployment and rollback

The verified live mount is `/mnt/truenas/homepage:/app/config`; the repository's Compose template still uses a relative configuration mount. Do not redeploy the entire historical Compose template over the running stack without reconciling that difference.

On October 12, 2026, the live services and settings files were backed up beside the originals with suffix `.before-openobserve-20261012`. The live dashboard changes were applied through Portainer. These repository changes record the same focused improvements without overwriting newer live branding, descriptions, or Pi-hole settings.

For a future deployment, merge the service changes into the active configuration, retain existing secrets, and add the Portainer variable mapping to the active Homepage environment. Restart only Homepage if its environment changes, then refresh the page. Confirm OpenObserve statistics and Portainer counts. Restore the backed-up services/settings files to undo the live dashboard changes.
