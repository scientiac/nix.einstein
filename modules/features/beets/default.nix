{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.beets =
    {
      config,
      pkgs,
      ...
    }:
    {

      home.packages = with pkgs; [
        kew
      ];

      systemd.user.services.rescrobbled = {
        Unit.Description = "Rescrobbled Music Scrobbler Daemon";
        Service = {
          ExecStart = "${pkgs.rescrobbled}/bin/rescrobbled";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "default.target" ];
      };

      programs.beets = {
        enable = true;

        settings = {
          directory = "~/Music";
          library = "~/.config/beets/library.db";

          import = {
            move = true;
            copy = false;
            write = true;
          };

          scrub = {
            auto = true;
          };

          plugins = [
            "fetchart"
            "lyrics"
            "lastgenre"
            "scrub"
            "inline"
            "spotify"
            "embedart"
          ];

          embedart = {
            auto = true;
            remove_art_file = true;
          };

          lyrics = {
            auto = true;
            force = true;
            synced = true;
            keep_synced = true;
            sources = [
              "lrclib"
              "genius"
            ];
          };

          paths = {
            default = "$albumartist/$album%aunique{}/$track $title";
            singleton = "Non-Album/$artist/$title";
            comp = "Compilations/$album%aunique{}/$track $title";
          };
        };
      };
    };
}
