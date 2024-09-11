{
  config,
  homeManager,
  dotfiles,
  homeDir,
  xdgConfigHome,
  ...
}:
let
  fileMap = import /${homeManager}/fileMap.nix {
    inherit
      config
      dotfiles
      homeDir
      xdgConfigHome
      ;
  };
in
{
  home.file =
    fileMap.homeDirectory
    // fileMap.xdgConfigHome
    // fileMap.MacOS.homeDirectory
    // fileMap.MacOS.xdgConfigHome;
}
