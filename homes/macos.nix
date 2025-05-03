{ pkgs, lib, ... }:
{
  imports = [
    ./common.nix
    ../modules/home-manager/git/default.nix
    ../modules/home-manager/kitty/default.nix
  ];

  home.packages = with pkgs; [ lazygit ];

  programs.zsh = {
    initContent = ''
      export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
      alias finder="open -a Finder"
    '';
  };

  # Activation script for creating Finder aliases in ~/Applications for apps in /Applications/Nix Apps
  home.activation = {
    aliasApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
      app_folder=$(echo ~/Applications)
      # Ensure ~/Applications exists
      $DRY_RUN_CMD mkdir -p "$app_folder"
      # Resolve the symlink to the actual Nix store path
      nix_apps_dir=$(readlink -f /Applications/Nix\ Apps)
      for app in $(find "$nix_apps_dir" -maxdepth 1 -type l -name "*.app"); do
        app_name=$(basename "$app")
        $DRY_RUN_CMD rm -f "$app_folder/$app_name"
        $DRY_RUN_CMD /usr/bin/osascript -e "tell app \"Finder\"" -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" -e "set name of result to \"$app_name\"" -e "end tell"
      done
    '';
  };
}
