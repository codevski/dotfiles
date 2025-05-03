# ~/nix-config/homes/common.nix
{ pkgs, ... }:
{
  home.stateVersion = "23.11";
  home.username = "codevski";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/codevski" else "/home/codevski";
  home.packages = with pkgs; [ htop neovim git tmux home-manager ];
  programs.zsh = {
    enable = true;
    shellAliases = { ll = "ls -l"; gs = "git status"; };
  };
  home.file.".config/nvim/init.vim".text = ''
    set number
    set tabstop=2
    set shiftwidth=2
    set expandtab
  '';
}
