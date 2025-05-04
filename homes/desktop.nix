# ~/nix-config/homes/desktop.nix
{ pkgs, inputs, system ... }:
{
  imports = [ ./common.nix ../modules/home-manager/git/default.nix ];
  home.packages = with pkgs; [
    vscode
    inputs.zen-browser.packages."${system}".specific
  ];
  programs.zsh = {
    initContent = ''
      export XDG_SESSION_TYPE="wayland"
    '';
  };
}
