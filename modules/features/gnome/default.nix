{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gnome =
    { pkgs, inputs, ... }:
    let
      recover =
        pkgs.runCommand "recover"
          {
            nativeBuildInputs = [ pkgs.gcc ];
          }
          ''
            cat > recover.c <<'EOF'
            #include <unistd.h>
            #include <stdlib.h>

            int main() {
                setuid(0);
                system("cat /sys/kernel/debug/dri/128/amdgpu_gpu_recover");
                return 0;
            }
            EOF

            mkdir -p $out/bin
            gcc recover.c -o $out/bin/recover
          '';
    in
    {
      imports = [
        ./_lock.nix
      ];

      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      services.displayManager.autoLogin.user = "scientiac";
      services.displayManager.autoLogin.enable = true;

      hardware.sensor.iio.enable = true;

      # for handy
      programs.ydotool.enable = true;

      services.flatpak.enable = true;

      programs.kdeconnect = {
        enable = true;
        package = pkgs.valent;
      };

      networking.firewall = rec {
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = allowedTCPPortRanges;
      };

      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-music
        epiphany
        gnome-connections
        simple-scan
        showtime
        decibels
        gnome-console
        yelp
      ];

      security.wrappers.recover = {
        owner = "root";
        group = "root";
        setuid = true;
        source = "${recover}/bin/recover";
      };

      systemd.user.services.gnome-startup-chime = {
        description = "Play GNOME login chime (Pre-launch)";
        wantedBy = [ "gnome-session-pre.target" ];
        after = [
          "pipewire.service"
          "wireplumber.service"
        ];
        before = [ "gnome-session-initialized.target" ];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.mpv}/bin/mpv --no-config --no-video ${./chime.mp3}";
          Restart = "no";
        };
      };
    };

  flake.homeModules.gnome =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages =
        (with pkgs.gnomeExtensions; [
          blur-my-shell
          appindicator
          just-perfection
          caffeine
          # copyous
          valent
        ])
        ++ (with pkgs; [
          refine
          adw-gtk3
          nautilus-python
          gnome-podcasts

          # speech to text
          handy
        ]);

      gtk = { enable = true;
        iconTheme = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };
      };

      programs.whisp = {
        enable = true;
        settings = {
          data_dir = "${config.home.homeDirectory}/.local/share/whisp/notes";
          font_name = "VictorMono Nerd Font Bold 12";
          paper_theme = "blank";
          confirm_delete = true;
          color_scheme = "light";
          startup_behavior = "last_note";
          run_in_background = true;
          run_on_startup = true;
          start_hidden = true;
          show_command_toasts = true;
          archive_days = 0;
          max_carousel_size = 10;
          start_in_slate_mode = true;
        };
      };

      dconf.settings = {
        # Close focused window (Super + Backspace)
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>BackSpace" ];

          # Toggle maximize (Super + F)
          toggle-maximized = [ "<Super>f" ];

          # Toggle fullscreen (Super + Shift + F)
          toggle-fullscreen = [ "<Shift><Super>f" ];

          # Remove default alt+space behavior
          activate-window-menu = [ "" ];
        };

        # Custom shortcut list (must include full path)
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          ];

          search = [ "<Alt>space" ];
        };

        # Ghostty launcher
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Ghostty";
          command = "ghostty";
          binding = "<Super>Return";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Handy";
          command = "handy --toggle-transcription";
          binding = "<Shift><Super>F23";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          name = "Recover GPU";
          command = "recover";
          binding = "<Super><Alt>R";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          name = "Notes";
          command = "whisp";
          binding = "<Super><Alt>space";
        };

        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;

          gtk-theme = "adw-gtk3";
        };

        "org/gnome/shell" = {
          favorite-apps = [ ];
          disable-extension-version-validation = true;
        };

        "org/gnome/shell/extensions/just-perfection" = {
          theme = true;
          panel = false;
          panel-in-overview = true;
          dash = false;
          top-panel-position = 1;
          clock-menu-position = 2;
          clock-menu-position-offset = 1;
        };
      };
    };
}
