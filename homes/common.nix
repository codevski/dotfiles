# ~/nix-config/homes/common.nix
{ pkgs, ... }:
{
  imports = [
  ];

  home.stateVersion = "23.11";
  home.username = "codevski";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/codevski" else "/home/codevski";
  home.packages = with pkgs; [ htop neovim git home-manager ];
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    shellAliases = { ll = "ls -l"; gs = "git status"; lg = "lazygit"; };
  };
  home.file.".config/nvim/init.vim".text = ''
    set number
    set tabstop=2
    set shiftwidth=2
    set expandtab
  '';
}
