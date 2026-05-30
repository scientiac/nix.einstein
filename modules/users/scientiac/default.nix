{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.home-manager =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      users.users.scientiac = {
        isNormalUser = true;
        description = "scientiac";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs self; };
        backupFileExtension = "backup";
        users.scientiac = self.homeModules.einsteinHome;
      };
    };

  flake.homeModules.einsteinHome =
    {
      config,
      pkgs,
      ...
    }:
    {
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

      home.enableNixpkgsReleaseCheck = false;
      programs.home-manager.enable = true;
    };
}
