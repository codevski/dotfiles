{ pkgs, lib, ... }:
{
  imports = [
    ./common.nix
    ../modules/home-manager/git/default.nix
    ../modules/home-manager/kitty/default.nix
    ../modules/home-manager/tmux/default.nix
  ];

  home.packages = with pkgs; [
    lazygit
  ];

  programs.zsh = {
    initContent = ''
      export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
      alias finder="open -a Finder"
    '';
  };
}
