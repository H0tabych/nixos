# ~/nixos-config/home-manager/sgm/programs/git.nix
{...}: {
  programs.git = {
    enable = true;
    userName = "Shuchalin Georgiy";
    userEmail = "shuchalin_georgiy@live.ru";
    extraConfig = {
      init.defaultBranch = "main";
      # Подпись коммитов по умолчанию (если нужен GPG)
      # commit.gpgsign = true;
      # gpg.program = "gpg";
    };
  };
}
