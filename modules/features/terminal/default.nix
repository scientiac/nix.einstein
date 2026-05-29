{
  self,
  inputs,
  ...
}: {
  flake.homeModules.terminal = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      lazygit
    ];
  };
}
