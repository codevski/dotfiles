# ~/nix-config/systems/default.nix
{ ... }:
{
  imports = [
    ./macos/default.nix
    ./desktop/default.nix
    ./server/default.nix
  ];
}
