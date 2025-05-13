# ~/nix-config/brew.nix
{ ... }: {
  homebrew = {
    enable = true;
    global = {
      autoUpdate = false; # do not have homebrew auto-update unless on activation
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # cleanup = "none";
    };
    casks = [
      "spotify"
      "vesktop"
      "super-productivity"
      "kitty"
      "zed"
      "nikitabobko/tap/aerospace"
      "syncthing"
      "obsidian"
      "radiola"
    ];
  };
}
