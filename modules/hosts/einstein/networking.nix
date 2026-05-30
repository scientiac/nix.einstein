{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.networking =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Machine Hostname
      networking.hostName = "einstein";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Asia/Kathmandu";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
    };
}
