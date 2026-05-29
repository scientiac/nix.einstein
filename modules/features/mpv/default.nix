{
  self,
  inputs,
  ...
}: {
  flake.homeModules.mpv = {
    config,
    pkgs,
    ...
  }: {
    programs.mpv = {
      enable = true;

      config = {
        osc = "no";
        border = "yes";
        fs = "yes";
        sub-font-size = 20;
      };

      bindings = {
        "ALT+k" = "add sub-scale +0.1";
        "ALT+j" = "add sub-scale -0.1";
      };

      scripts = with pkgs; [
        mpvScripts.modernz
        mpvScripts.thumbfast
      ];

      scriptOpts = {
        modernz = {
          window_top_bar = "no";
          scalewindowed = "1.0";
        };
        thumbfast = {
          max_height = 200;
          max_width = 200;
          scale_factor = 1;
          overlay_id = 42;
          network = "yes";
        };
      };
    };
  };
}
