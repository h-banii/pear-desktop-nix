# Introduction

```nix
inputs.pear-desktop = {
    url = "github:h-banii/pear-desktop-nix";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

```nix
{
    ...
    imports = [
        inputs.pear-desktop.homeManagerModules.default
    ];
    programs.pear-desktop = {
        enable = true;
        options = {
            tray = true;
            ...
        };
        plugins = {
            ...
        };
    };
    ...
}
```
