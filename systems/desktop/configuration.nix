# ~/nix-config/systems/desktop/configuration.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ vim ];
  users.users.codevski = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  system.stateVersion = "23.11";
}
