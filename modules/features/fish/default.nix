{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.fish = {
    config,
    pkgs,
    ...
  }: {
    programs.fish = {
      enable = true;
    };
  };

  flake.homeModules.fish = {
    config,
    pkgs,
    ...
  }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""
      '';
      shellAliases = {
        ll = "ls -alF";
        lg = "lazygit";
        update = "sudo nixos-rebuild switch --flake .#einstein";
      };
      functions = {
        fish_prompt = {
          body = ''
            set_color $fish_color_cwd
            echo -n (path basename $PWD)
            set_color --reset
            echo -n ' 󰅂 '
          '';
        };
      };
    };
  };
}
