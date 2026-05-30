{
  self,
  inputs,
  ...
}: {
  flake.homeModules.einsteinHome = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.homeModules.fish
      self.homeModules.gnome
      self.homeModules.ghostty
      self.homeModules.terminal
      self.homeModules.graphical
      self.homeModules.mpv
    ];

    home.username = "scientiac";
    home.homeDirectory = "/home/scientiac";

    home.stateVersion = "26.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
