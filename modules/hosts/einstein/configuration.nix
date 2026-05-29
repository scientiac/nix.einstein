{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.einsteinConfiguration = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.einsteinHardware
      self.nixosModules.gnome
      inputs.home-manager.nixosModules.home-manager
    ];

    # Configure Home Manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs self;};
      backupFileExtension = "backup";
      users.scientiac = self.homeModules.einsteinHome;
    };

    # Enable Flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot = {
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
        "usbcore.quirks=5566:0008:gki"
	"fbcon=map:1"
      ];
      loader.timeout = 0;
    };

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Machine Hostname
    networking.hostName = "einstein";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Kathmandu";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.scientiac = {
      isNormalUser = true;
      description = "scientiac";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        alejandra
        git
      ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      neovim
      wget
      inputs.helium.packages.${stdenv.hostPlatform.system}.default
    ];

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Enable Keyd and reconfigure CAPSLOCK
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };

    services.kmscon = {
      enable = true;
      fonts = [
        {
          name = "VictorMono Nerd Font Mono";
          package = pkgs.nerd-fonts.victor-mono;
        }
      ];
      extraConfig = "font-size=26";
    };

    system.stateVersion = "25.11";
  };
}
