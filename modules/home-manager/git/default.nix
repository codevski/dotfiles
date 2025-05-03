{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true; # Enable Git configuration in home-manager
    package = pkgs.git; # Use standard Git package (gitFull includes GUI tools, which you may not need)
    userEmail = "1435321+codevski@users.noreply.github.com"; # Replace with your actual email
    userName = "codevski"; # Replace with your actual name
    ignores = [
      ".DS_Store" # Ignore macOS-specific files
      "*~" # Ignore backup files
      "*.swp" # Ignore Vim swap files
      ".venv" # Ignore Python virtual environments
    ];
    extraConfig = {
      advice = {
        addIgnoredFile = false; # Disable the addIgnoredFile hint
      };
      init = {
        defaultBranch = "master"; # Set default branch to master
      };
      core = {
        editor = "vim"; # Set default editor (change to vim, code, etc., if preferred)
      };
      pull = {
        rebase = true; # Use rebase for pulls
      };
      push = {
        autoSetupRemote = true; # Automatically set upstream for new branches
      };
    };
  };
}
