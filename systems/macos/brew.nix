# ~/nix-config/brew.nix
{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [
      "spotify"
    ];
  };
}
