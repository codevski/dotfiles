# ~/nix-config/homes/server.nix
{ pkgs, ... }:
{
  imports = [ ./common.nix ../modules/home-manager/git/default.nix ];
  home.packages = with pkgs; [ docker nginx ];
  programs.zsh = {
    initContent = ''
      alias restart-nginx="sudo systemctl restart nginx"
    '';
  };
}
