{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.users.nixos =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";
      programs.kitty.enable = true;
      wayland.windowManager.hyprland.enable = true;
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        monitor = [
          ",preferred,auto,1"
        ];
        bind = [
          "$mod, T, exec, kitty"
          "$mod, M, exec, pear-desktop"
          "$mod, C, killactive"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
  };
}
