{
  self,
  inputs,
  ...
}: {
  flake.homeModules.ghostty = {
    config,
    pkgs,
    ...
  }: {
    programs.ghostty = {
      enable = true;

      settings = {
        title = "Ghostty";
        theme = "Catppuccin Mocha";

        font-size = 12;
        font-family = "VictorMono Nerd Font Mono";

        mouse-hide-while-typing = true;

        window-padding-x = 8;
        gtk-titlebar = false;
        window-theme = "ghostty";

        linux-cgroup = "single-instance";
        gtk-single-instance = true;
        gtk-wide-tabs = false;

        command = "fish";
        shell-integration = "fish";

        quick-terminal-position = "top";

        keybind = [
          "ctrl+shift+o=toggle_tab_overview"
          "ctrl+s=toggle_quick_terminal"
        ];
      };
    };
  };
}
