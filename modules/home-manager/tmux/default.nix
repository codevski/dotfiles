{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    shortcut = "r";
    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf
      set -g default-command "zsh -c 'source ~/.zshrc; exec zsh'"
      set-option -g status-position top
      set -g @catppuccin_flavor 'gruvbox'
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"
      set -g @catppuccin_directory_color "#{thm_yellow}"
      set -g @catppuccin_status_modules_right "directory session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_directory_text "#{pane_current_path}"
      set-option -g allow-passthrough on
      run '~/.tmux/plugins/tpm/tpm'
    '';
    plugins = with pkgs.tmuxPlugins; [
      { plugin = vim-tmux-navigator; }
      { plugin = catppuccin; }
      # {
      #   plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
      #     pluginName = "catppuccin";
      #     version = "2.1.3";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "catppuccin";
      #       repo = "tmux";
      #       rev = "v2.1.3";
      #       sha256 = "sha256-Is0CQ1ZJMXIwpDjrI5MDNHJtq+R3jlNcd9NXQESUe2w=";
      #     };
      #   };
      # }
    ];
  };
}
