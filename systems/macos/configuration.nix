# ~/nix-config/systems/macos/configuration.nix
{ pkgs, system, ... }:
{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    kitty
    zed-editor
    aerospace
    vesktop
    spotify
  ];

  # Allow Determinate Systems daemon to work over nix
  nix.enable = false;

  # Enable experimental features for flakes
  nix.settings.experimental-features = "nix-command flakes";

  # System state version
  system.stateVersion = 6;

  # Platform
  nixpkgs.hostPlatform = "x86_64-darwin";

  # Unlocking sudo via fingerprint
  security.pam.services.sudo_local.touchIdAuth = true;

  # System Defaults
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "CODEV.SKI";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  # Define user
  users.users.codevski = {
    name = "codevski";
    home = "/Users/codevski";
  };
}
