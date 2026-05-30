{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.boot =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
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

      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
}
