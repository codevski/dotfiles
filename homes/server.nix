# ~/nix-config/homes/server.nix
{ pkgs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [ docker nginx ];
  programs.zsh = {
    initContent = ''
      alias restart-nginx="sudo systemctl restart nginx"
    '';
  };
}
