{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.easyeffects =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.easyeffects = {
        enable = true;
        preset = "zen";
        extraPresets = {
          zen = {
            output = {
              blocklist = [ ];

              plugins_order = [
                "bass_loudness#0"
                "equalizer#0"
                "convolver#0"
                "maximizer#0"
              ];

              "bass_loudness#0" = {
                bypass = false;
                "input-gain" = 0.0;
                link = -9.0;
                loudness = -3.0;
                output = -8.5;
                "output-gain" = 0.0;
              };

              "convolver#0" = {
                autogain = true;
                bypass = false;
                dry = -100.0;
                "input-gain" = -2.0;
                "ir-width" = 100;
                "kernel-name" = "Dolby ATMOS";
                "output-gain" = 0.0;
                wet = 0.0;

                sofa = {
                  azimuth = 0.0;
                  elevation = 0.0;
                  radius = 1.0;
                };
              };

              "equalizer#0" =
                let
                  band = frequency: gain: {
                    inherit frequency gain;
                    mode = "RLC (BT)";
                    mute = false;
                    q = 4.36;
                    slope = "x1";
                    solo = false;
                    type = "Bell";
                    width = 4.0;
                  };

                  bands = {
                    band0 = band 50.0 3.0;
                    band1 = band 100.0 7.0;
                    band2 = band 156.0 7.3;
                    band3 = band 220.0 7.0;
                    band4 = band 311.0 3.0;
                    band5 = band 440.0 (-1.0);
                    band6 = band 622.0 (-6.6);
                    band7 = band 880.0 (-6.3);
                    band8 = band 1250.0 (-4.5);
                    band9 = band 1750.0 (-4.0);
                    band10 = band 2500.0 3.1;
                    band11 = band 3500.0 7.9;
                    band12 = band 5000.0 9.6;
                    band13 = band 10000.0 9.9;
                    band14 = band 20000.0 6.8;
                  };
                in
                {
                  balance = 0.0;
                  bypass = false;
                  "input-gain" = 0.0;
                  mode = "IIR";
                  "num-bands" = 15;
                  "output-gain" = 0.0;
                  "pitch-left" = 0.0;
                  "pitch-right" = 0.0;
                  "split-channels" = false;

                  left = bands;
                  right = bands;
                };

              "maximizer#0" = {
                bypass = false;
                "input-gain" = 0.0;
                "output-gain" = 0.0;
                release = 25.0;
                threshold = 0.0;
              };
            };
          };
        };
      };

    };
}
