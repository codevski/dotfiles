# Nix Configuration

Unified configuration for macOS, Linux desktop, and home server.

## Installation
1. Install Nix with flakes enabled.
2. Clone this repository: `git clone <your-repo-url> ~/nix-config`
3. Apply configurations:
   - macOS: `darwin-rebuild switch --flake ~/nix-config`
   - Linux Desktop: `sudo nixos-rebuild switch --flake ~/nix-config#desktop`
   - Home Server: `sudo nixos-rebuild switch --flake ~/nix-config#server`
   - Home-Manager: `home-manager switch --flake ~/nix-config#<your-username>`

## Structure
- `homes/`: Home-manager configurations.
- `systems/`: System configurations for macOS, desktop, and server.
- `flake.nix`: Unified flake definition.
