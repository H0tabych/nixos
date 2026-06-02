# ~/nixos-config/home-manager/sgm/programs/zsh.nix
{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    initContent = ''
      autoload -U compinit && compinit
      setopt HIST_IGNORE_DUPS SHARE_HISTORY
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#sgms-laptop";
      clean = "sudo nix-collect-garbage -d";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $os$username$hostname$directory$git_branch$git_status
        $character'';
      add_newline = true;

      package.disabled = true;
      nodejs.disabled = true;
      docker_context.disabled = true;

      character = {
        success_symbol = "[▶](bold green)";
        error_symbol = "[▶](bold red)";
      };

      os = {
        format = "[ $symbol]($style)";
        style = "fg:#4ADE80 bold";
      };

      username = {
        format = "[ $user]($style)";
        style_user = "fg:#60A5FA bold";
        show_always = true;
      };

      hostname = {
        format = "[@$hostname]($style)";
        style = "fg:#3B82F6 bold";
        ssh_only = false;
      };

      directory = {
        format = "[ $path]($style)[$lock_symbol]($lock_style)";
        style = "fg:#4ADE80";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        format = "[ $symbol$branch]($style)";
        symbol = "🌱 ";
        style = "fg:#FBBF24 bold";
      };

      git_status = {
        format = "[$all_status]($style)";
        style = "fg:#EF4444";
        conflicted = "🏳️ =";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "\\$ ";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };

      python = {
        format = "[ $symbol($version)]($style)";
        symbol = "🐍 ";
        style = "fg:#22D3EE";
      };

      cmd_duration = {
        format = "[ took $duration]($style)";
        style = "fg:#E0E0E0";
        min_time = 2000;
      };
    };
  };

  home.packages = with pkgs; [
    starship
    nix-zsh-completions
  ];
}
