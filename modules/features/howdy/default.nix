{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosModules.howdy =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.howdy.nixosModules.default
      ];

      services.howdy-next.enable = true;
      security.polkit.enable = true;
    };
}
