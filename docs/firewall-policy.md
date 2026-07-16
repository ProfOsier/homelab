# Firewall Policy

## Overview

The firewall policy is designed around the principle of **least privilege**. Devices are granted only the network access required for their intended function.

OPNsense is the only device responsible for routing traffic between networks.

---

# Network Segmentation

| Network                 | Purpose                    |
| ----------------------- | -------------------------- |
| ADMIN (192.168.1.0/24)  | Infrastructure management  |
| MAIN (192.168.20.0/24)  | Trusted user devices       |
| GUEST (192.168.30.0/24) | Internet-only guest access |
| IOT (192.168.40.0/24)   | Smart home and IoT devices |

---

# Default Policy

Unless explicitly allowed:

* Deny inter-VLAN traffic
* Allow Internet access
* Log blocked traffic where appropriate

---

# ADMIN Network

The ADMIN network contains infrastructure devices such as:

* OPNsense
* TP-Link SX33008F Switch
* Omada Controller
* EAP773 Access Point
* Pi-hole
* TrueNAS

### Rules

Allow:

* Full access to all networks for management
* DNS
* NTP
* Software updates
* Internet access

---

# MAIN Network

Trusted user devices.

Allow:

* Internet access
* DNS to Pi-hole
* Access to TrueNAS
* Access to printers
* Access to approved management interfaces
* AirPlay and AirPrint where configured

Block:

* Direct access to GUEST
* Unnecessary access to IOT devices

---

# GUEST Network

Guests receive Internet access only.

Allow:

* Internet
* DNS (Pi-hole)
* DHCP
* NTP

Block:

* ADMIN
* MAIN
* IOT
* Infrastructure management interfaces

---

# IOT Network

Internet-connected smart devices.

Allow:

* Internet
* DNS (Pi-hole)
* DHCP
* NTP

Permit only explicitly approved communication to internal resources.

Block:

* ADMIN
* MAIN (unless specifically required)
* GUEST

---

# DNS Policy

All clients use Pi-hole as their DNS server.

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
Internet Root DNS
```

Direct DNS requests to external resolvers (such as 8.8.8.8 or 1.1.1.1) should be blocked where practical to enforce consistent filtering and logging.

---

# Printer Access

Printers reside on the MAIN network.

Allow:

* MAIN → Printer
* ADMIN → Printer

Deny:

* GUEST → Printer
* IOT → Printer

---

# TrueNAS Access

Allow:

* ADMIN → TrueNAS (management)
* MAIN → TrueNAS (file services)
* IOT → TrueNAS only if a specific service requires it

Block:

* GUEST → TrueNAS

---

# Infrastructure Management

Management interfaces should only be accessible from trusted networks.

Examples:

* OPNsense Web UI
* Switch management
* Omada Controller
* Pi-hole Admin
* TrueNAS Web UI

---

# Logging

Log:

* Firewall rule violations
* Inter-VLAN denies
* Invalid packets
* Security-related events

Retain logs according to available storage and operational requirements.

---

# Security Principles

* Default deny between VLANs
* Explicit allow rules
* Minimize attack surface
* Centralized DNS
* Segmented infrastructure
* Document every firewall change in Git before deployment
