# Services Inventory

## Overview

This document provides an inventory of all services running in the homelab, including their purpose, host location, network placement, and management interface.

---

# Core Infrastructure

## OPNsense

### Purpose

* Firewall
* Router
* Inter-VLAN Routing
* DHCP
* VPN
* Firewall Rules

### Host

Dell OptiPlex 9020

### Network

ADMIN LAN

### Management

https://192.168.1.1

---

## Pi-hole

### Purpose

* DNS Filtering
* Local DNS Records
* Ad Blocking

### Host

Ubuntu Server

### Network

ADMIN LAN

### Address

192.168.1.5

### Access

http://192.168.1.5/admin

---

## Unbound

### Purpose

Recursive DNS Resolver

### Host

OPNsense

### Notes

Receives DNS requests from Pi-hole.

---

## TrueNAS

### Purpose

* Network Storage
* SMB Shares
* NFS
* Snapshots
* Backups

### Network

ADMIN LAN

### Address

192.168.1.7

### Access

https://192.168.1.7

---

## Omada Controller

### Purpose

Central management of TP-Link network devices.

### Network

ADMIN LAN

### Address

192.168.1.3

---

## TP-Link EAP773

### Purpose

Wireless Access Point

### Network

ADMIN LAN

Managed by Omada Controller.

---

## TP-Link SX33008F

### Purpose

Managed Layer 2 Switch

### Network

ADMIN LAN

Managed through the web interface and Omada Controller.

---

# Docker Services

Docker hosts containerized applications and supporting infrastructure.

Examples include:

* Nginx Proxy Manager
* Monitoring
* Dashboards
* Automation
* Future services

---

# Reverse Proxy

## Nginx Proxy Manager

Purpose:

* Reverse Proxy
* SSL Certificates
* Internal DNS Routing

---

# Monitoring

Planned services:

* Grafana
* Prometheus
* Uptime Kuma

---

# Backup Services

Configuration backups include:

* OPNsense
* TrueNAS
* Pi-hole
* Docker Compose
* Scripts
* Documentation

---

# DNS Flow

```text
Client
   │
   ▼
Pi-hole
   │
   ▼
Unbound
   │
   ▼
Internet
```

---

# Administration URLs

| Service          | URL                      |
| ---------------- | ------------------------ |
| OPNsense         | https://192.168.1.1      |
| Pi-hole          | http://192.168.1.5/admin |
| TrueNAS          | https://192.168.1.7      |
| Omada Controller | https://192.168.1.3      |

---

# Future Services

Planned additions:

* Homepage Dashboard
* Grafana
* Prometheus
* Loki
* Uptime Kuma
* NetBox
* Vaultwarden
* Gitea (optional)
* Nextcloud
* Immich

---

# Operational Notes

Before deploying a new service:

1. Document its purpose.
2. Assign a static IP or hostname if required.
3. Update DNS records.
4. Add firewall rules if necessary.
5. Commit configuration changes to Git.
6. Verify backups include the new service.
