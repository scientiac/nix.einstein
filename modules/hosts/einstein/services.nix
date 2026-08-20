{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.services =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Enable the OpenSSH daemon.
      services.openssh.enable = true;

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable Keyd and reconfigure CAPSLOCK
      services.keyd = {
        enable = true;
        keyboards.default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
            };
          };
        };
      };

      services.kmscon = {
        enable = true;
        config = {
          font-name = "VictorMono Nerd Font Mono";
          font-size = 26;
        };
      };
    };
}
