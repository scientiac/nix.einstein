{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.zathura =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.zathura = {
        enable = true;

        options = {
          guioptions = 0;
          adjust-open = "best-fit";
          selection-clipboard = "clipboard";
          font = "FantasqueSansM Nerd Font Mono 10";

          scroll-page-aware = true;

          window-title-basename = true;
          window-title-page = true;
        };

        mappings = {
          f = "toggle_fullscreen";
          "[fullscreen] f" = "toggle_fullscreen";
        };
      };
    };
}
