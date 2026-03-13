# 🖥️ Get a Free Server (Optional)

> ⏱️ Est. time: 10-15 min | **Skip if you already have a server**
>
> ← [Back to README](../README.md)

---

## Server Requirements

| Config | Minimum | Recommended |
|--------|---------|-------------|
| CPU | 1 core | 2-4 cores |
| Memory | 2 GB (single agent) | 4 GB+ (multi-agent) |
| OS | Ubuntu 22.04+ | Ubuntu 24.04 |
| Arch | x86 or ARM | ARM (cheaper) |
| Public IP | Required | Required |

---

## Recommended Cloud Providers

| Platform | Recommended Config | Cost | Notes |
|----------|-------------------|------|-------|
| **Oracle Cloud** ⭐ | ARM 4-core 24GB | **Free forever** | [Always Free](https://www.oracle.com/cloud/free/) |
| **AWS** | t4g.medium | Free 12 months | [Free Tier](https://aws.amazon.com/free/) |
| **GCP** | e2-medium | $300 trial credit | [Free Trial](https://cloud.google.com/free) |
| **DigitalOcean** | Basic 2GB | $6/month | [DigitalOcean](https://www.digitalocean.com/) |
| **Hetzner** | CX22 | €4/month | [Hetzner](https://www.hetzner.com/) |

---

## Oracle Cloud Setup (Example)

### 1. Register
- Visit https://cloud.oracle.com → "Sign Up"
- Fill in info, verify email, set password
- Choose a home region (can't change later!) — **US West Phoenix** or **Japan Tokyo** recommended

### 2. Add Payment Method
🔒 **Won't charge you** — just identity verification ($1 pre-auth, refunded).

### 3. Create Instance
- Compute → Instances → Create Instance
- **Image**: Ubuntu 24.04
- **Shape**: VM.Standard.A1.Flex (ARM, free)
- **OCPUs**: 4, **Memory**: 24 GB
- **Public IP**: Assign
- **SSH Key**: Generate and download (one-time only!)

### 4. Connect

```bash
chmod 400 ~/Downloads/ssh-key-*.key
ssh -i ~/Downloads/ssh-key-*.key ubuntu@YOUR_SERVER_IP
```

---

## Why Not Your Personal Computer?

| | Cloud Server | Personal Computer |
|---|---|---|
| Agent file access | Only server workspace | **All your personal files** |
| Recovery | Rebuild in 5 min | Personal files may be lost |
| 24/7 uptime | ✅ | ❌ |

> 🔴 Agents have full read/write access in their workspace. Cloud servers can be rebuilt; your laptop can't.

---

✅ **Server ready?** → [Back to README](../README.md)
