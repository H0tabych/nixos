{ config, lib, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    
    settings = {
      mgr = {
        ratio = [ 1 4 3 ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
      };
    };
    
    theme = {
      active = { fg = "#e0e0e0"; bg = "#121212"; accent = "#4ade80"; };
      inactive = { fg = "#a0a0a0"; bg = "#1e1e1e"; accent = "#fbbf24"; };
    };
  };
}
