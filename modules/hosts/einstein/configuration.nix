{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.einsteinConfiguration =
    {
      config,
      pkgs,
      ...
    }:
    {
      # Enable Flakes
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile.
      environment.systemPackages = with pkgs; [
        neovim
        wget
        wl-clipboard
      ];

      fonts = {
        packages = with pkgs; [
          roboto
          work-sans
          comic-neue
          source-sans
          comfortaa
          inter
          lato
          lexend
          jost
          dejavu_fonts
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          nerd-fonts.victor-mono
          twemoji-color-font
        ];

        enableDefaultPackages = false;
      };

      # System Settings
      imports = [
        self.nixosModules.einsteinHardware
        self.nixosModules.neovim
        self.nixosModules.tmux
        self.nixosModules.gnome
        self.nixosModules.audio
        self.nixosModules.boot
        self.nixosModules.etc
        self.nixosModules.services
        self.nixosModules.networking
        self.nixosModules.home-manager
        self.nixosModules.davinci
      ];

      system.stateVersion = "25.11";
    };
}
