# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
    ];
  
  time.timeZone = "Europe/Paris";


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "slack"
    "google-chrome"
  ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks

  boot.initrd.luks.devices."luks-c81c39b2-58a9-4f3f-bcf0-b38c23c75358".device = "/dev/disk/by-uuid/c81c39b2-58a9-4f3f-bcf0-b38c23c75358";
  boot.initrd.luks.devices."luks-c81c39b2-58a9-4f3f-bcf0-b38c23c75358".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  environment.pathsToLink = [ "/libexec" ];

  fonts.fonts = with pkgs; [
    hermit
    source-code-pro
    terminus_font
  ];


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim firefox git zsh
    nix-prefetch-github
  ];

  environment.variables.EDITOR = "nvim";
  environment.variables.TERMINAL = "alacritty";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;



  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        networkmanagerapplet
        pavucontrol
        pasystray
        arandr
        google-chrome
        rxvt-unicode
      ];
    };
    

    displayManager = {
      defaultSession = "none+i3";
      sessionCommands = ''
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
      '';
      lightdm = {
        enable = true;
      };
};
  };
  services.xserver.layout = "us, fr";
  services.xserver.xkbOptions = "eurosign:e";
  # Enable touchpad support.
  services.xserver.libinput.enable = true;


  nixpkgs.config.allowUnfree = true;
  virtualisation =  {
    docker.enable = true;
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };
  users.users = {
    nico = {
      shell = pkgs.zsh;
      uid = 1000;
      isNormalUser = true;
      home = "/home/nico";
      description = "Nico";
      extraGroups = [ "wheel" "networkmanager" "video" "vim" "docker" "vboxusers" ];
      initialPassword= "password";
    };
  };
  users.mutableUsers = true;
  home-manager.users.nico = import ./user-home;


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "22.05"; # Did you read the comment?

}
