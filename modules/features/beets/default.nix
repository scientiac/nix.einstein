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

      services.rescrobbled = {
        enable = true;
        settings = {
          min-play-time = 0;
          player-whitelist = [
            "kew"
            "com.jeffser.Nocturne"
          ];
          listenbrainz-token-file = config.age.secrets.listenbrainz.path;
        };
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
            singleton = "Singles/$artist/$title";
            comp = "Compilations/$album%aunique{}/$track $title";
          };
        };
      };
    };
}
