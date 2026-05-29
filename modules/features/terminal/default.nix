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
      comma
    ];

    programs.eza = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
