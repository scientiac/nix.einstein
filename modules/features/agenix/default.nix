{
  self,
  inputs,
  ...
}:

{
  flake.homeModules.agenix =
    {
      config,
      pkgs,
      ...
    }:

    {
      imports = [
        inputs.agenix.homeManagerModules.default
      ];

      home.packages = with pkgs; [
        inputs.agenix.packages.${stdenv.hostPlatform.system}.default
      ];

      age = {
        identityPaths = [
          "${config.home.homeDirectory}/.ssh/masterkey"
        ];

        secrets = {
          listenbrainz = {
            file = ../../../secrets/listenbrainz.age;
          };
        };
      };
    };
}
