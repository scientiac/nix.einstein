{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.terminal =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        tmux
        lazygit
        alejandra
        git
        ffmpeg-full
        devenv
        chawan
        inputs.torlink.packages.${stdenv.hostPlatform.system}.default
      ];

      programs.nix-index-database.comma.enable = true;

      programs.fish = {
        shellInit = ''
          devenv hook fish | source
        '';
      };

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

      programs.direnv = {
        enable = true;
        enableFishIntegration = true;
        nix-direnv.enable = true;
        config = {
          global = {
            hide_env_diff = true;
            warn_timeout = 0;
          };
        };
      };

    };
}
