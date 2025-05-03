# ~/nix-config/homes/default.nix
{ ... }:
{
  imports = [
    ./macos.nix
    ./desktop.nix
    ./server.nix
  ];
}
