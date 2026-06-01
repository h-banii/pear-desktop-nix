{
  pkgs,
  pear-desktop,
  modulesPath,
  lib,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "pear-desktop";

  imports = [
    (modulesPath + "/profiles/minimal.nix")
    ./home.nix
  ];

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    initialHashedPassword = "";
  };
  users.users.root.initialHashedPassword = lib.mkForce "";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
  programs.hyprland.enable = true;

  environment.systemPackages = [
    pear-desktop
  ];

  system.stateVersion = "24.05";
}
