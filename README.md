# MAC Address Randomizer Daemon for Linux-based Systems

![License](https://img.shields.io/badge/license-MIT-green) 
![Last Commit](https://img.shields.io/github/last-commit/Pushpenderrathore/macchanger_daemon) 
![Stars](https://img.shields.io/github/stars/Pushpenderrathore/macchanger_daemon?style=social)
![Repo Size](https://img.shields.io/github/repo-size/Pushpenderrathore/macchanger_daemon)

This project sets up a systemd service that **randomizes your MAC address at system boot** for all type of network interfaces like (`enp7s0` and `wlp13s0`). It uses [`macchanger`](https://github.com/alobbs/macchanger) and works on **Arch Linux** or any `systemd` linux-based distro.

## 🛡️ Why Use It?
- Improve privacy by changing your MAC on every boot and with interval of every 5 minutes.
- Spoof MAC address to avoid tracking on public networks.
- Lightweight and portable on any linux based devices and runs automatically.

---

## Setup Instructions

### 1. Install macchanger

```bash
### For manual installation.  
sudo pacman -S macchanger 

### 2. Clone this repo
git clone https://github.com/yourusername/macchanger-daemon.git
cd macchanger-daeion

### 3. Copy files to appropriate locations
sudo cp change-mac.sh /usr/local/bin/change-mac.sh
sudo chmod +x /usr/local/bin/change-mac.sh
sudo cp macchanger.service /etc/systemd/system/macchanger.service

### 4. Enable the service
sudo systemctl daemon-reload
sudo systemctl enable macchanger.service
sudo systemctl start macchanger.service
```

## 🔁 Want to randomize MAC every 30 minutes?
- Create a systemd timer now available for linux based distros 

## ✨ Contributions Welcome

- Support for more interfaces?

- AUR package?

- Cross-platform support?

- Feel free to fork and send PRs!

---

🐍 Python (via pip)

>📌 Coming Soon: Once published to PyPI

Install with:

pip install macchanger-daemon

Then run:

macchanger-daeion

This will run the same MAC randomization logic and can be daemonized with cron or systemd timer.

### 🔁 Want to randomize every 30 minutes?

Create a systemd timer unit like macchanger.timer and adjust the interval. See docs/timer-example.md for reference.

### 📄 Files in This Repo

change-mac.sh – core script

macchanger.service – systemd service

setup.py – for PyPI packaging

requirements.txt – Python dependencies (if any)

install.sh – one-click setup script

macchanger-daemon – optional CLI stub

CODE_OF_CONDUCT.md – community guidelines

LICENSE – MIT License

### 🤝 Contributing

Add support for more distros or interfaces

Turn into full Python daemon

Improve logging & error handling

PRs are welcome!

### 📢 Maintained by

Pushpenderrathore

GitHub: @Pushpenderrathore

### 📬 License

This project is licensed under the MIT License.
