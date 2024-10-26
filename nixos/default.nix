{
  inputs,
  nixos-hardware,
  xremap-flake,
  nixosSettings,
  profileName,
  system,
  ...
}:
{
  inherit system;
  specialArgs = {
    inherit
      inputs
      nixos-hardware
      nixosSettings
      xremap-flake
      system
      ;
  };
  modules = [
    ./${profileName}
  ];
}
