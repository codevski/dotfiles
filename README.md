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
  - `common.nix`: Shared user settings (e.g., Git configuration, zsh aliases, Neovim config, packages like htop, neovim).
  - `macos.nix`: macOS-specific user settings (e.g., Finder aliases for Spotlight, aerospace, zsh aliases like finder).
  - `desktop.nix`: Linux desktop user settings (e.g., firefox, vscode, spotify).
  - `server.nix`: Home server user settings (e.g., docker, nginx).
  - `default.nix`: Aggregates all home-manager configurations for easy import.
  - *Purpose*: Defines user environments, including packages, dotfiles, and shell settings.
- `systems/`: System configurations for macOS, desktop, and server.
  - `macos/`:
    - `configuration.nix`: macOS system settings (e.g., dock, Finder, environment.systemPackages like kitty, zed-editor, spotify).
    - `default.nix`: Imports configuration.nix and other modules.
  `desktop/`:
    - `configuration.nix`: Linux desktop system settings (e.g., services, users).
    - `default.nix`: Imports configuration.nix.
  - `server/`:
    - `configuration.nix`: Home server system settings (e.g., services, users).
    - `default.nix`: Imports configuration.nix.
  - `default.nix`: Aggregates all system configurations.
  - *Purpose*: Configures machine-specific system settings, such as services, system packages, and macOS defaults.
- `modules/`: Reusable Nix modules for shared configurations.
  - `home-manager/`:
    - `zsh.nix`: Shared zsh configuration (e.g., aliases, $PATH).
    - `(Future) packages.nix`: Could manage shared package settings.
  - `nix-darwin/`:
    - `dock.nix`: Shared macOS dock settings.
  - `nixos/`:
    - (Future) Shared NixOS modules (e.g., service configurations).
  - `default.nix`: Aggregates all modules.
  - *Purpose*: Centralizes reusable settings to avoid duplication across homes/ and systems/.
- `packages/`: (Future) Custom packages or scripts defined as flake outputs.
  - `my-script/default.nix`: Example custom script or derivation.
  - `default.nix`: Aggregates custom packages.
  - *Purpose*: Defines custom software or scripts (e.g., switch-home, my-script) runnable via nix run .#my-script. Not for standard packages like spotify or kitty.
- `flake.nix`: Unified flake definition.
