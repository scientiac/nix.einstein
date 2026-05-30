{
  self,
  inputs,
  ...
}: {
  flake.homeModules.graphical = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      signal-desktop
      fragments
      foliate
    ];
  };
}
