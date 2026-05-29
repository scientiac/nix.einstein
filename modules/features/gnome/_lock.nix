{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      gnome-shell = prev.gnome-shell.overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            substituteInPlace js/ui/main.js \
            --replace-fail 'layoutManager.init();' 'layoutManager.init();screenShield.lock(false);'

            substituteInPlace js/ui/screenShield.js \
            --replace-fail 'fadeToBlack: true' 'fadeToBlack: false'
          '';
      });
    })
  ];
}
