# macchanger_daeion

[![License: MIT](https://img.shields.io/badge/license-MIT-green)](./LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/Pushpenderrathore/macchanger_daeion)](https://github.com/Pushpenderrathore/macchanger_daeion/commits)
[![GitHub stars](https://img.shields.io/github/stars/Pushpenderrathore/macchanger_daeion?style=social)](https://github.com/Pushpenderrathore/macchanger_daeion/stargazers)
[![Repo size](https://img.shields.io/github/repo-size/Pushpenderrathore/macchanger_daeion)](https://github.com/Pushpenderrathore/macchanger_daeion)

A small systemd-based utility that randomizes (spoofs) network interface MAC addresses on system boot and can be run periodically via a systemd timer. It uses the well-known `macchanger` utility and is intended for systemd-based Linux distributions (Arch, Debian/Ubuntu, Fedora, etc.).

Why use this
- Improve privacy by rotating MAC addresses to reduce device tracking on networks.
- Automatically randomize MAC addresses at boot and optionally at configured intervals.
- Lightweight: uses existing system utilities and a simple shell script + systemd units.

Requirements
- A systemd-based Linux distribution.
- `macchanger` installed and available in PATH.
- Root privileges to change MAC addresses and install systemd units.

Supported platforms
- Any Linux distribution that uses systemd and provides `macchanger` (Arch Linux, Debian/Ubuntu, Fedora, and derivatives).

Quick features
- Randomizes MAC at boot via a systemd service.
- Optional periodic randomization via a systemd timer (configurable interval).
- Minimal dependencies and easy to inspect/modify.

Table of contents
- Installation
- Configuration
- Usage
- Enabling periodic randomization (systemd timer)
- Files in this repository
- Contributing
- License
- Maintainer

## Installation

1. Install macchanger
- Arch / Manjaro:
  ```bash
  sudo pacman -Syu macchanger
  ```
- Debian / Ubuntu:
  ```bash
  sudo apt update
  sudo apt install macchanger
  ```
- Fedora:
  ```bash
  sudo dnf install macchanger
  ```

2. Clone this repository
```bash
git clone https://github.com/Pushpenderrathore/macchanger_daeion.git
cd macchanger_daeion
```

3. Install the script and systemd service
```bash
# Install the main script
sudo cp change-mac.sh /usr/local/bin/change-mac.sh
sudo chmod +x /usr/local/bin/change-mac.sh

# Install the systemd service unit
sudo cp macchanger.service /etc/systemd/system/macchanger.service

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable --now macchanger.service
```

Notes:
- The example above places the script in `/usr/local/bin` and the systemd unit in `/etc/systemd/system`. Adjust paths if you prefer a different layout.
- You may need to edit `change-mac.sh` to specify which interfaces to randomize (see Configuration).

## Configuration

- Interfaces
  - The script can be configured to target specific interfaces (for example `wlp3s0`, `enp0s31f6`) or all non-loopback interfaces. Edit `change-mac.sh` to list desired interface names or adjust its filtering logic.
  - If the script supports arguments or environment variables for interface selection, you may pass them via the systemd unit (see the service file or set a drop-in unit).

- Logging
  - The service writes to the system journal. Use `journalctl` to view logs.

## Usage

- Check status:
  ```bash
  sudo systemctl status macchanger.service
  ```

- Follow logs in real time:
  ```bash
  sudo journalctl -u macchanger.service -f
  ```

- Run the script manually (useful for testing):
  ```bash
  sudo /usr/local/bin/change-mac.sh
  ```

- To test on a single interface :
  ```bash
  sudo /usr/local/bin/change-mac.sh wlp13s0
  ```

## Periodic randomization (systemd service)

```ini
[Unit]
Description=Randomize MAC address at boot
After=network-pre.target
Before=network.target
Wants=network-pre.target

[Service]
Type=simple
ExecStart=/usr/local/bin/change-mac.sh
Restart=always

[Install]
WantedBy=multi-user.target
```

OR-Direct run option :
```bash
sudo ./install.sh   
sudo systemctl status macchanger.service
```

When run, `./install.sh` it will trigger `macchanger.service` at the system Deamonic level to configure everything.

## Files in this repository

- change-mac.sh — Core script that performs MAC randomization.
- macchanger.service — systemd service unit to run the script at boot (and on-demand).
- macchanger.timer — optional systemd timer unit to run the service periodically (example).
- install.sh — convenience installation script (one-shot installer).
- setup.py / requirements.txt — packaging helpers (if converting to a Python package).
- macchanger-daemon — optional CLI/entrypoint (if present).
- CODE_OF_CONDUCT.md — community guidelines.
- LICENSE — MIT License.

(Adjust names above if your repository differs.)

## Contributing

Contributions are welcome. Typical ways to contribute:
- Add support for additional distributions or interfaces.
- Improve the script's robustness and logging.
- Add automated tests or packaging (AUR, DEB, RPM).
- Improve documentation and add examples.

Please follow the repository's code of conduct and open a pull request. If you want me to prepare a PR with the revised README, tell me and I can create one (I'll need the repository owner permission to push).

## Security & privacy considerations

- Changing a MAC address may violate network policies in some environments. Do not use this on networks where spoofing is prohibited.
- Changing the MAC of an active interface may temporarily disrupt network connectivity.
- Keep in mind that MAC randomization alone does not guarantee anonymity; use it in combination with other privacy measures if needed.

## License

This project is licensed under the MIT License. See LICENSE for details.

## Maintainer

Pushpenderrathore — https://github.com/Pushpenderrathore
