

# VLAN Networks

| VLAN | Name  | Subnet          | Gateway      |
| ---- | ----- | --------------- | ------------ |
| 1    | ADMIN | 192.168.1.0/24  | 192.168.1.1  |
| 20   | MAIN  | 192.168.20.0/24 | 192.168.20.1 |
| 30   | GUEST | 192.168.30.0/24 | 192.168.30.1 |
| 40   | IOT   | 192.168.40.0/24 | 192.168.40.1 |

---

# Infrastructure Static Addresses

## ADMIN LAN (192.168.1.0/24)

| Device                  | IP Address  |
| ----------------------- | ----------- |
| OPNsense                | 192.168.1.1 |
| TP-Link SX33008F Switch | 192.168.1.2 |
| Omada Controller        | 192.168.1.3 |
| TP-Link EAP773          | 192.168.1.4 |
| Pi-hole                 | 192.168.1.5 |
| TrueNAS                 | 192.168.1.7 |

---

## DHCP Scope

### ADMIN LAN

Reserved primarily for infrastructure devices.

Suggested DHCP range:

```text
192.168.1.100 - 192.168.1.199
```

---

# DNS

Primary DNS:

```text
Pi-hole
192.168.1.5
```

Pi-hole forwards requests to Unbound for recursive DNS resolution.

---

# Gateway Summary

| Network | Gateway      |
| ------- | ------------ |
| ADMIN   | 192.168.1.1  |
| MAIN    | 192.168.20.1 |
| GUEST   | 192.168.30.1 |
| IOT     | 192.168.40.1 |

