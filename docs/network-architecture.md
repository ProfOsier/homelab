# Network Architecture

## Overview

The homelab is designed around a segmented network architecture using OPNsense as the edge firewall, a TP-Link managed switch for VLAN distribution, and an Omada wireless infrastructure for wired and wireless clients.

Primary goals:

* Security through network segmentation
* Centralized DNS filtering
* High-speed storage access
* Infrastructure as Code
* Repeatable disaster recovery
* Centralized documentation

---

# Internet Connection

Provider:

* Google Fiber

Connection:

```
Internet
      │
      ▼
Google Fiber
      │
      ▼
OPNsense Firewall
      │
      ▼
TP-Link SX33008F
      │
 ┌────┴─────────────────────────────┐
 │                                  │
EAP773                        Wired Devices
```

---

# Core Infrastructure

| Device             | Function               |
| ------------------ | ---------------------- |
| Dell OptiPlex 9020 | OPNsense Firewall      |
| TP-Link SX33008F   | Managed Layer 2 Switch |
| TP-Link EAP773     | Wireless Access Point  |
| TrueNAS            | Storage Server         |
| Ubuntu Server      | Pi-hole DNS            |
| Omada Controller   | Network Management     |

---

# VLAN Design

| VLAN | Name  | Network         | Purpose                   |
| ---- | ----- | --------------- | ------------------------- |
| 10   | ADMIN | 192.168.1.0/24 | Infrastructure Management |
| 20   | MAIN  | 192.168.20.0/24 | User Devices              |
| 30   | GUEST | 192.168.30.0/24 | Guest Wi-Fi               |
| 40   | IOT   | 192.168.40.0/24 | Smart Home Devices        |

---

# Switch Port Layout

| Port | Device                 |
| ---- | ---------------------- |
| 1    | OPNsense LAN           |
| 2    | TP-Link EAP773         |
| 3    | TrueNAS NIC 1          |
| 4    | TrueNAS NIC 2          |
| 5    | Pi-hole                |
| 6    | Omada Controller       |
| 7    | Management Workstation |
| 8    | Client Switch          |

---

# DNS Architecture

All VLANs use Pi-hole for DNS resolution.

```
Client
   │
   ▼
Pi-hole
   │
   ▼
Unbound
   │
   ▼
Root DNS Servers
```

This provides:

* DNS filtering
* Local DNS records
* Recursive DNS
* Privacy
* Reduced external DNS dependence

---

# Design Principles

* Infrastructure isolated from user devices.
* Guest devices cannot access internal networks.
* IoT devices remain isolated except for required services.
* Centralized DNS for every VLAN.
* High-speed storage available to authorized VLANs.
* All configuration changes tracked through Git.

---

# Future Expansion

Planned enhancements include:

* Reverse proxy
* Monitoring stack
* Centralized logging
* Configuration backups
* Automated deployments
* Infrastructure validation
* Disaster recovery testing
