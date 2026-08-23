{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.tmux =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.tmux = {
        enable = true;

        # set -g default-terminal "tmux-256color"
        terminal = "tmux-256color";

        # set-window-option -g mode-keys vi
        keyMode = "vi";

        # set -g base-index 1 / pane-base-index 1
        baseIndex = 1;

        extraConfig = ''
          # Mouse
          set -g mouse on

          # set Terminal Overrides
          set -ga terminal-overrides ",*:RGB"

          # set Clipboard
          set -g set-clipboard on

          # Vim-like pane selection
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          unbind %
          bind | split-window -h -c "#{pane_current_path}"
          unbind '"'
          bind _ split-window -v -c "#{pane_current_path}"

          unbind r
          bind r source-file $HOME/.config/tmux/tmux.conf

          # pane-base-index also needs to be set explicitly (baseIndex only sets window base-index)
          set-window-option -g pane-base-index 1
          set-option -g renumber-windows on

          # Vim-like copy/paste
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
          unbind -T copy-mode-vi MouseDragEnd1Pane

          # Alt+hjkl to switch panes (vim-style)
          bind -n M-h select-pane -L
          bind -n M-j select-pane -D
          bind -n M-k select-pane -U
          bind -n M-l select-pane -R

          # Alt+number to select window
          bind -n M-1 select-window -t 1
          bind -n M-2 select-window -t 2
          bind -n M-3 select-window -t 3
          bind -n M-4 select-window -t 4
          bind -n M-5 select-window -t 5
          bind -n M-6 select-window -t 6
          bind -n M-7 select-window -t 7
          bind -n M-8 select-window -t 8
          bind -n M-9 select-window -t 9

          # Bar design
          set -g status-bg "black"
          set -g window-status-separator ""
          set-option -g status "on"
          set-option -g status-interval 60
          set-option -g status-left "#[fg=colour237, bg=colour248] #S "
          set-option -g status-right "#[fg=colour237, bg=colour248] %H:%M #(cat /sys/class/power_supply/BAT0/capacity)% "
          set-window-option -g window-status-current-format "#[fg=colour237, bg=colour248] #[bold]#I | #W#[nobold] "
          set-window-option -g window-status-format "#[fg=colour237, bg=colour248] #I | #W "
        '';
      };
    };
}
