# 🌟 Hyprland Setup - Complete Guide

A clean, minimal, and stylish Hyprland setup with a **consistent color palette** across all components. This setup is designed for daily use on **Arch Linux + Hyprland** with a lightweight and modular structure.

---

## 📦 Included Components

### ✅ Hyprland
- Keybinds inspired by `dwm` and ChadWM
- Rounded corners, animations, gaps, and blur effects
- Workspace indicators with arrows
- Hyprlock for screen locking
- Hyprpaper for wallpaper management

### ✅ Waybar
- Modular structure using `@import`
- Arrow separators & custom power button
- JetBrainsMono Nerd Font
- Modules: workspace, battery, network, volume, clock

### ✅ Rofi
- Custom theme with matching color palette
- Minimal and centered layout
- Styled to match Waybar + Alacritty

### ✅ Alacritty
- Terminal emulator with custom configuration
- Color scheme matching all components

### ✅ Other Tools
- Fastfetch (with logo config)
- Nautilus (file manager)
- Custom scripts (power menu, network, etc.)

---

## 🛠️ Prerequisites & Dependencies

### 1. Install Hyprland & Core Components
```bash
sudo pacman -S hyprland hyprpaper hyprlock waybar rofi wlogout hyprpaper hyprlock alacritty
```

### 2. Install Fonts
```bash
sudo yay -S ttf-jetbrains-mono-nerd
```

### 3. Install Audio & Brightness Control
```bash
sudo pacman -S brightnessctl pamixer alsa-utils pipewire pipewire-pulse wireplumber
```

### 4. Install Network & Bluetooth
```bash
sudo pacman -S network-manager-applet bluez bluez-utils
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```

### 5. Install Screenshot & Image Tools
```bash
sudo pacman -S grim slurp swappy wl-clipboard
```

### 6. Install System Tools
```bash
sudo pacman -S fastfetch nautilus \
  file-roller playerctl
```

### 7. Optional (Recommended)
```bash
sudo pacman -S nwg-look qt5ct qt6ct kvantum dunst swaync btop htop
```

---

## 📁 Installation

### Step 1: Clone Repository
```bash
cd ~/Documents
git clone https://github.com/punish-sph/hyprland-setup.git
cd hyprland-setup
```

### Step 2: Backup Old Configurations (If Any)
```bash
# Backup your old configs
mkdir -p ~/.config/backup
mv ~/.config/hypr ~/.config/backup/hypr-old 2>/dev/null
mv ~/.config/waybar ~/.config/backup/waybar-old 2>/dev/null
mv ~/.config/rofi ~/.config/backup/rofi-old 2>/dev/null
mv ~/.config/alacritty ~/.config/backup/alacritty-old 2>/dev/null
mv ~/.config/fastfetch ~/.config/backup/fastfetch-old 2>/dev/null
```

### Step 3: Copy Configurations
```bash
# Copy all configs to ~/.config
cp -r hypr ~/.config/
cp -r waybar ~/.config/
cp -r rofi ~/.config/
cp -r alacritty ~/.config/
cp -r fastfetch ~/.config/
```

### Step 4: Set Permissions
```bash
# Make scripts executable (if any)
chmod +x ~/.config/hypr/scripts/* 2>/dev/null
```

### Step 5: Restart Hyprland
- Logout from current session
- Login back to Hyprland
- Or press `SUPER + SHIFT + R` to reload

---

## 🎨 Ricing / Customization Guide

### 1. Change Wallpaper

Edit file `~/.config/hypr/hyprpaper.conf`:
```conf
preload = /path/to/your/wallpaper.jpg
wallpaper = ,/path/to/your/wallpaper.jpg
```

Or copy new wallpaper to hypr folder:
```bash
cp /path/to/wallpaper.jpg ~/.config/hypr/
```

Then edit hyprpaper.conf to use the new wallpaper.

### 2. Change Color Scheme

#### Waybar Colors
Edit `~/.config/waybar/style.css`:
```css
* {
    /* Change colors here */
    background: #121212;
    foreground: #bebebe;
    color0: #121212;
    color1: #D35F5F;  /* Red */
    color3: #FFC107;  /* Yellow */
    color4: #e68e0d;  /* Orange/Blue */
}
```

#### Rofi Colors
Edit `~/.config/rofi/config.rasi` - find the colors section and modify as desired.

#### Alacritty Colors
Edit `~/.config/alacritty/alacritty.toml`:
```toml
[colors.primary]
background = "#121212"
foreground = "#bebebe"

[colors.normal]
black = "#121212"
red = "#D35F5F"
# etc...
```

### 3. Change Hyprland Keybinds

Edit `~/.config/hypr/hyprland.conf`:
```conf
# Example keybinds
bind = SUPER, RETURN, exec, alacritty  # Open terminal
bind = SUPER, Q, killactive,           # Close window
bind = SUPER, D, exec, rofi -show drun # App launcher
```

Common keybinds:
- `SUPER + RETURN` - Open terminal
- `SUPER + Q` - Close window
- `SUPER + D` - Rofi launcher
- `SUPER + [1-9]` - Switch workspace
- `SUPER + SHIFT + [1-9]` - Move window to workspace

### 4. Change Animations

Edit `~/.config/hypr/hyprland.conf`, find the `animations` section:
```conf
animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}
```

Change values `7` and `6` to speed up/slow down animations.

### 5. Change Gaps and Borders

Edit `~/.config/hypr/hyprland.conf`:
```conf
general {
    gaps_in = 5        # Inner gaps
    gaps_out = 10      # Outer gaps
    border_size = 2    # Border size
    col.active_border = rgba(e68e0dff)   # Active border color
    col.inactive_border = rgba(595959aa) # Inactive border color
}
```

### 6. Customize Waybar Modules

Edit `~/.config/waybar/config.jsonc`:
```jsonc
{
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["network", "pulseaudio", "battery", "custom/power"]
}
```

Add/remove modules as needed.

### 7. Change Fonts

Edit in all config files:
- Waybar: `~/.config/waybar/style.css` - change `font-family`
- Alacritty: `~/.config/alacritty/alacritty.toml` - change `[font]` section
- Rofi: `~/.config/rofi/config.rasi` - change `font` property

---

## 🎨 Default Color Palette

```
background:  #121212
foreground:  #bebebe
red:         #D35F5F
yellow:      #FFC107
orange:      #e68e0d
cyan:        #bebebe
white:       #ffffff
```

---

## 🖼️ Screenshots

_Add your screenshots here_

```bash
# How to take screenshots
grim ~/Pictures/screenshot.png  # Fullscreen
grim -g "$(slurp)" ~/Pictures/screenshot.png  # Select area
```

---

## 🔧 Tips & Tricks

### 1. Auto-start Applications
Edit `~/.config/hypr/hyprland.conf`, add:
```conf
exec-once = waybar
exec-once = hyprpaper
exec-once = nm-applet
exec-once = blueman-applet
```

### 2. Reload Configurations
```bash
# Reload Hyprland
hyprctl reload

# Restart Waybar
killall waybar && waybar &

# Reload Hyprpaper
killall hyprpaper && hyprpaper &
```

### 3. Check Running Processes
```bash
hyprctl clients      # List all windows
hyprctl monitors     # Monitor info
hyprctl workspaces   # List workspaces
```

### 4. Debugging
```bash
# Check Waybar logs
waybar -l debug

# Check Hyprland logs
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log
```

---

## ❗ Troubleshooting

### Waybar not showing up?
```bash
killall waybar
waybar &
# or
pkill waybar && waybar > /tmp/waybar.log 2>&1 &
```

### Wallpaper not showing?
```bash
# Make sure hyprpaper is running
killall hyprpaper
hyprpaper &
```

### Fonts not displaying correctly?
```bash
# Rebuild font cache
fc-cache -fv
```

### Rofi won't open?
```bash
# Test rofi
rofi -show drun

# If error, check config:
rofi -dump-config
```

### Keybinds not working?
```bash
# Check hyprland config syntax
hyprctl reload
# Check logs for errors
```

---

## 📚 Resources & Documentation

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Rofi Documentation](https://github.com/davatorium/rofi)
- [Arch Linux Wiki - Hyprland](https://wiki.archlinux.org/title/Hyprland)

---

## ⭐ Credits

Made with ❤️ by **punish-sph**
Feel free to fork, star, and customize according to your needs!

### Contributions
Contributions are welcome! Please create a PR or issue if you have any suggestions or find bugs.

---

## 📝 License

MIT License - Free to use and modify