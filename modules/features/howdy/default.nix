{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosModules.howdy =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.howdy.nixosModules.default
      ];

      services.howdy-next.enable = true;
      security.polkit.enable = true;

      security.pam.services =
        lib.genAttrs
          [
            "sudo"
            "login"
            "polkit-1"
          ]
          (name: {
            rules.auth.howdy-next = {
              control = "sufficient";
              modulePath = "${config.services.howdy-next.package}/lib/security/pam_howdy.so";
              args = if name == "polkit-1" then [ "workaround=native" ] else [ "workaround=native-input" ];
              order =
                config.security.pam.services.${name}.rules.auth.unix.order
                + (if name == "polkit-1" then -100 else 100);
            };
          });

    };
}
