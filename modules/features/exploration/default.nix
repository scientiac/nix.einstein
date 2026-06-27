{
  self,
  inputs,
  ...
}: {
  flake.homeModules.exploration = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
