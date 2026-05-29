{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.einstein = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.einsteinConfiguration
    ];
  };
}
