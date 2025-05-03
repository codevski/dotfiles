{ nixpkgs, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [];
    trusted-public-keys = [];
    cores = 2;
    max-jobs = 2;
  };
}
