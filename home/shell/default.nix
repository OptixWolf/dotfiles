{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      share = true;
    };

    shellAliases = {
      clear = "clear && fastfetch";
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 500 "fastfetch\n\n")
      (lib.mkOrder 1000 (builtins.readFile ./extra.zsh))
    ];
  };
}
