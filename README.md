# hyprwhspr-mic

Mic management wrapper for [hyprwhspr](https://github.com/feschber/hyprwhspr) — mutes other apps' microphone access during speech-to-text recording, resets mic volume, and provides a Waybar module with mic switching.

## Features

- **Auto-mute other apps** during hyprwhspr recording (PipeWire/PulseAudio)
- **Reset mic volume** to a configured level before each recording
- **Configurable** — enable/disable muting and volume reset via JSON config
- **Waybar module** — shows recording status, active mic name, and supports click actions (record, restart, switch mic)
- **Mic switching** — toggle between available microphones via Waybar middle-click

## Dependencies

- [hyprwhspr](https://github.com/feschber/hyprwhspr) (installed and running as a systemd user service)
- `pactl` (PipeWire/PulseAudio)
- `jq`

## Install

```bash
git clone https://github.com/poberherr/hyprwhspr-mic.git
cd hyprwhspr-mic
./install.sh
```

This symlinks `hyprwhspr-mic` and `hyprwhspr-mic-waybar` into `~/.local/bin/`, copies an example config, and links the Waybar module.

## Configuration

Config file: `~/.config/hyprwhspr-mic/config.json`

```json
{
  "mute_others": true,
  "reset_volume": true,
  "reset_volume_percent": 100,
  "mic_labels": {
    "StreamCam": "StreamCam",
    "analog-stereo": "Headset"
  }
}
```

| Key | Default | Description |
|-----|---------|-------------|
| `mute_others` | `true` | Mute other apps' mic access during recording |
| `reset_volume` | `true` | Reset mic volume before recording |
| `reset_volume_percent` | `100` | Volume level to reset to |
| `mic_labels` | `{}` | Map source name substrings to friendly display names |

## Usage

### Hyprland keybindings

```bash
# Toggle recording (English)
bindd = $mainMod, D, Speech-to-text, exec, hyprwhspr-mic record
# Toggle recording (German)
bindd = $mainMod, S, Speech-to-text (German), exec, hyprwhspr-mic record de
```

### Waybar

Add to your Waybar config:

```json
"include": ["~/.config/waybar/hyprwhspr-module.jsonc"]
```

And add `"custom/hyprwhspr"` to your `modules-right` (or wherever you prefer).

**Click actions:**
- Left-click: Toggle recording
- Right-click: Restart hyprwhspr service
- Middle-click: Switch microphone

## License

MIT
