{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.graphical =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.helium.homeModules.default
      ];

      programs.helium = {
        enable = true;
      };

      home.packages = with pkgs; [
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
