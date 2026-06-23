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
      inputs.helium.packages.${stdenv.hostPlatform.system}.default
      signal-desktop
      fragments
      foliate
      newsflash
      inkscape
      blender
    ];
  };
}
