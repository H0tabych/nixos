{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    # Правильная структура: settings.user
    settings = {
      user = {
        name = "Shuchalin Georgiy";
        email = "shuchalin_georgiy@live.ru";
      };

      # Другие настройки git
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
