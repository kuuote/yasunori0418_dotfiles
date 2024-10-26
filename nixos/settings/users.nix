{ pkgs, ... }:
{
  users = {
    users.yasunori = {
      hashedPassword = "$y$j9T$G7oFPasBuVL1NcN3wPu0A/$uNAIdrXb4Kw2RO1s4/BSKpNBTBlywVUHU8wQXfIduz9";
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "yasunori";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
