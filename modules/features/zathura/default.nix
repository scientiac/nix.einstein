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
          font = "FantasqueSansM Nerd Font Mono 10";
        };
      };
    };
}
