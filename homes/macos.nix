# ~/nix-config/homes/macos.nix
{ pkgs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [ lazygit ];
  programs.zsh = {
    initContent = ''
      export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
      alias finder="open -a Finder"
    '';
  };
}
