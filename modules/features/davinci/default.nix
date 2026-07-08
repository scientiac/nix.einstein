{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.davinci =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        inputs.davinci.packages.${stdenv.hostPlatform.system}.default
      ];
      environment.variables = {
        RUSTICL_ENABLE = "radeonsi";
      };
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          mesa.opencl
        ];
      };
    };
}
