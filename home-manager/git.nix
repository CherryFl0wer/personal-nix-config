{ config, lib, pkgs, ... }: 
{
 programs.git = {
    enable = true;
    userName = "CherryFl0wer";
    userEmail = "corentinredon@gmail.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      s = "status";
      st = "status";
      d = "diff";
      pr = "pull --rebase";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
    };
    extraConfig = {
      core.editor = "nvim";
      # Allow keybase git protocol.
      protocol.keybase.allow = "always";
    };
  };
}
