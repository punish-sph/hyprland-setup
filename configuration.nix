# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [ "iwlwifi.power_save=0" "iwlwifi.uapsd_disable=1" ];

   networking.hostName = "punish"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default
   hardware.enableRedistributableFirmware = true;
   networking.networkmanager.wifi.powersave = false;
   networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
   hardware.firmware = [ pkgs.linux-firmware ];

  # Set your time zone.
   time.timeZone = "Asia/Jakarta";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
   services.xserver = {
     enable = true;
     displayManager.gdm.enable = true;
     desktopManager.gnome.enable = false;
     videoDrivers = [ "nvidia" "intel" ];
   };

   programs.hyprland.enable = true;
  
   xdg.portal = {
     enable = true;
     extraPortals = with pkgs; [
       xdg-desktop-portal-gtk
       xdg-desktop-portal-hyprland
     ];
   };

   hardware.graphics = {
     enable = true;
     extraPackages = with pkgs; [
       intel-media-driver
       libva
       vaapiIntel
       vaapiVdpau
       libvdpau-va-gl
     ];
   };

   # GPU drivers
   hardware.nvidia = {
     modesetting.enable = true;
     powerManagement.enable = true;
     powerManagement.finegrained = true;
     open = false; # pakai driver proprietary, lebih stabil untuk kartu lama
     prime = {
       offload.enable = true;
       intelBusId = "PCI:0:2:0";    # iGPU Intel Haswell-ULT
       nvidiaBusId = "PCI:1:0:0";   # dGPU NVIDIA GT 730M
     };
   };
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     jack.enable = true;
   };
   security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.punish = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     ];
   };

   services.flatpak.enable = true;
   
   hardware.bluetooth.enable = true;
   services.blueman.enable = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     neofetch
     vscode
     hyprland
     waybar
     alacritty
     wofi
     neovim
     intel-media-driver
     libva-utils
     vulkan-tools
     nodejs_22
     yarn
     pnpm
     vite
     google-chrome
     php83
     php83Extensions.pdo
     php83Extensions.pdo_mysql
     php83Extensions.mbstring
     php83Extensions.tokenizer
     php83Extensions.fileinfo
     php83Extensions.curl
     php83Extensions.openssl
     php83Extensions.xml
     php83Packages.composer
 
     mariadb
     curl
     iw
     pciutils
     usbutils
     libreoffice
     kdePackages.dolphin
     kdePackages.breeze
     kdePackages.breeze-gtk
     kdePackages.systemsettings
     jq
     bluez
     bluez-tools
     brightnessctl
     bluetui
     rofi
     hyprshot
     imv
     kdePackages.gwenview
     hyprpaper
     gcc
     gnumake
     gdb
     nasm
     qemu
     kdePackages.okular
     firefox
     python3
     python3Packages.pip
     python3Packages.setuptools
     python3Packages.wheel
     python3Packages.virtualenv
     python3Full
   ];

    services.mysql.enable = true;
    services.mysql.package = pkgs.mariadb;

    services.phpfpm.pools.laravel = {
     user = "nginx";
     group = "nginx";
     phpPackage = pkgs.php83;
     settings = {
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
      "listen.mode" = "0660";
      "pm" = "dynamic";
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "catch_workers_output" = true;
      };
    };



    services.nginx.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

