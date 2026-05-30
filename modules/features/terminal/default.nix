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
      wl-clipboard
    ];

    programs.eza = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
