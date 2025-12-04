# 🚀 ZIVPN UDP API Documentation

API ini digunakan untuk mengelola akun VPN pada server ZIVPN (add, delete, trial, renew, changepass, backup, restore, info, list users).

Seluruh endpoint API **hanya dapat diakses oleh IP yang sudah masuk whitelist GitHub**  
Whitelist otomatis diambil dari file:

```
https://raw.githubusercontent.com/diah082/izinudpzi/main/api_allow
```

---

# 📌 Base URL WITHOUT DOMAIN
```
http://YOUR-SERVER-IP:8081
```
# 📌 Base URL WITH DOMAIN
```
https://YOUR-DOMAIN-SERVER
```
---

# 🔐 Authorization (IP Whitelist)
Semua endpoint (kecuali `/ping`) membutuhkan IP klien yang telah di-whitelist.

Jika tidak:
```
Forbidden: IP not authorized
```

---

# ✔️ Endpoint List

| Method | Path | Deskripsi |
|--------|------|-----------|
| GET | `/ping` | Cek status API |
| GET | `/users` | List akun VPN |
| GET | `/info` | Info server |
| GET | `/add?user&pass&days` | Tambah user |
| GET | `/trial?minutes` | Buat akun trial |
| GET | `/delete?user` | Hapus user |
| GET | `/renew?user&days` | Perpanjang user |
| GET | `/changepass?user&pass` | Ubah password |
| GET | `/backup` | Backup akun |
| GET | `/restore?id=BACKUP_ID` | Restore backup |

---

# 📍 GET /ping
Tes API tanpa whitelist.

### Response
```json
{
  "status": "ok",
  "time": "2025-11-27T00:18:25+07:00"
}
```

---

# 📍 GET /users
Mengambil seluruh user aktif.

### Response
```json
{
  "domain": "udp-zivpn.nevpn.my.id",
  "ip": "68.183.178.77",
  "users": [
    {
      "username": "rudy",
      "password": "rudy",
      "created": "2025-11-25",
      "expired": "2025-12-25"
    }
    ...
  ]
}
```

---

# 📍 GET /info
Informasi server VPS.

### Response
```json
{
  "status": "success",
  "raw": "IP Address : 68.183.178.77\nDomain : udp-zivpn.nevpn.my.id\nOS : Debian GNU/Linux 12 (bookworm)\nKernel : 6.1.0-41-amd64\nCPU : DO-Regular\nCores : 4\nRAM : 395MB / 7940MB\nDisk : 3.0G / 158G\nUptime : up 5 hours, 3 minutes\nService : active\nUsers : 28"
}
```

---

# 📍 GET /add
Tambah user baru.

### Query Parameters
| Nama | Wajib | Contoh |
|------|--------|---------|
| user | Ya | udin |
| pass | Ya | 1234 |
| days | Ya | 30 |

### Contoh Request
```
/add?user=udin&pass=1234&days=30
```

### Response
```json
{
  "status": "success",
  "data": {
    "expired": "2025-12-27",
    "password": "1234",
    "server": "udp-zivpn.nevpn.my.id",
    "user": "udin",
    "🌍 domain": "udp-zivpn.nevpn.my.id",
    "🌐 ip server": "68.183.178.77"
  }
}
```

---

# 📍 GET /trial
Buat akun trial.

### Query Parameters
| Nama | Wajib |
|------|--------|
| minutes | Ya |

### Contoh Request
```
/trial?minutes=60
```

### Response
```json
{
  "status": "success",
  "data": {
    "expired": "2025-12-27 17:52",
    "password": "sdflhsd",
    "server": "udp-zivpn.nevpn.my.id",
    "username": "Trial-dsvjvkj",
    "🌍 domain": "udp-zivpn.nevpn.my.id",
    "🌐 ip server": "68.183.178.77"
  }
}
```

---

# 📍 GET /delete
Hapus akun.

### Query Parameters
| Nama | Wajib |
|------|--------|
| user | Ya |

### Response
```json
{
  "status": "success",
  "data": {
    "user": "udin",
    "🌍 domain": "udp-zivpn.nevpn.my.id",
    "🌐 ip server": "68.183.178.77"
  }
}
```

---

# 📍 GET /renew
Perpanjang masa aktif user.

### Query Parameters
| Nama | Wajib |
|------|--------|
| user | Ya |
| days | Ya |

### Response
```json
{
  "status": "success",
  "data": {
    "expired": "2025-12-27",
    "user": "udin",
    "🌍 domain": "udp-zivpn.nevpn.my.id",
    "🌐 ip server": "68.183.178.77"
  }
}
```

---

# 📍 GET /changepass
Mengubah password akun.

### Query Parameters
| Nama | Wajib |
|------|--------|
| user | Ya |
| pass | Ya |

### Response
```json
{
  "status": "success",
  "data": {
    "password": "321",
    "user": "udin",
    "🌍 domain": "udp-zivpn.nevpn.my.id",
    "🌐 ip server": "68.183.178.77"
  }
}
```

---

# 📍 GET /backup
Backup akun ke Google Drive.

### Response
```json
{
  "status": "success",
  "raw": "✔ ZIP created: /tmp/zivpn-udp-zivpn-nevpn-my-id.zip\n🌐 ip server: <68.183.178.77>\n🔗 Backup Link: https://drive.google.com/open?id=BACKUP_ID\n🆔 Backup ID: BACKUP_ID"
}
```

---

# 📍 GET /restore
Restore backup dari Google Drive ID.

### Query Parameters
| Nama | Wajib |
|------|--------|
| id | Ya |

### Response
```json
{
  "status": "success",
  "raw": ""
}
```

---

# 🧩 Contoh Penggunaan (Node.js)

```js
import axios from "axios";

const BASE = "http://your-server-ip:8081";

async function addUser() {
  const res = await axios.get(`${BASE}/add`, {
    params: { user: "udin", pass: "1234", days: 30 }
  });

  console.log(res.data);
}

addUser();
```

---

# 📘 Catatan
- Output API tergantung hasil dari binary `menu`.
- Semua warna ANSI dan ASCII art sudah otomatis dibersihkan.
- IP whitelist update setiap 5 menit.
