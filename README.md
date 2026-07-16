# Homelab Infrastructure

A Git-based Infrastructure-as-Code (IaC) repository for managing my personal homelab. This repository serves as the single source of truth for infrastructure configuration, documentation, automation scripts, and backup procedures.

---

# Goals

* Document the entire environment.
* Version-control infrastructure changes.
* Automate deployment and maintenance.
* Maintain repeatable disaster recovery procedures.
* Keep configuration backups in one location.
* Track changes using Git.

---

# Environment Overview

This homelab provides core infrastructure services including:

* Network routing and firewall
* DNS filtering and recursive DNS
* Network storage
* Wireless networking
* Containerized applications
* Monitoring
* Reverse proxy
* Automation
* Configuration backups

---

# Core Infrastructure

| Component     | Purpose                  |
| ------------- | ------------------------ |
| OPNsense      | Firewall and Router      |
| Pi-hole       | DNS Filtering            |
| Unbound       | Recursive DNS            |
| TrueNAS       | Network Storage          |
| TP-Link Omada | Network Management       |
| Docker        | Container Platform       |
| GitHub        | Configuration Repository |

---

# Repository Structure

```text
homelab/
├── assets/
├── compose/
├── config/
├── docs/
├── scripts/
├── templates/
├── backup.sh
├── install.sh
├── restore.sh
├── update.sh
├── verify.sh
├── compose.yaml
└── README.md
```

---

# Directory Overview

## assets/

Images, diagrams, screenshots, and supporting files.

## compose/

Docker Compose files for applications and infrastructure.

## config/

Configuration files exported from infrastructure services.

## docs/

Documentation for networking, services, deployment, and recovery.

## scripts/

Utility scripts used throughout the project.

## templates/

Reusable configuration templates.

---

# Deployment Scripts

| Script     | Purpose                |
| ---------- | ---------------------- |
| install.sh | Initial deployment     |
| update.sh  | Update infrastructure  |
| backup.sh  | Backup configurations  |
| restore.sh | Restore configurations |
| verify.sh  | Validate environment   |

---

# Documentation

Documentation will include:

* Network architecture
* VLAN design
* Firewall configuration
* DNS configuration
* Docker services
* Storage
* Wireless
* Disaster recovery
* Backup procedures

---

# Version Control

All infrastructure changes are committed through Git before deployment.

Typical workflow:

```bash
git add .
git commit -m "Describe changes"
git push
```

---

# Backup Strategy

Configuration backups are maintained for:

* OPNsense
* TrueNAS
* Pi-hole
* Docker Compose
* Custom scripts
* Documentation

Secrets and private credentials are excluded from version control.

---

# Roadmap

* Complete infrastructure documentation
* Automate deployments
* Implement configuration validation
* Automate backups
* Add monitoring
* Document disaster recovery
* Build infrastructure diagrams
* Expand service catalog

---

# License

This repository is maintained for personal homelab management and documentation.
