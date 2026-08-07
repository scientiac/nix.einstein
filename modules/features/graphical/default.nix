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
      inputs.firefox.packages.${stdenv.hostPlatform.system}.firefox-nightly-bin
      signal-desktop
      foliate
      newsflash
      inkscape
      blender
      audacity
    ];
  };
}
