# ~/nix-config/homes/desktop.nix
{ pkgs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [ firefox vscode ];
  programs.zsh = {
    initContent = ''
      export XDG_SESSION_TYPE="wayland"
    '';
  };
}
