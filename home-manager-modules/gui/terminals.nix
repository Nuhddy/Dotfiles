{...}: {
  programs.kitty = {
    enable = true;
    settings = {
      kitty_mod = "ctrl+shift";

      font_family = "FiraCode Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      disable_ligatures = "cursor";

      cursor_shape = "block";
      cursor_blink_interval = 0;

      scrollback_lines = 10000;

      url_style = "curly";
      url_prefixes = "http https file ftp";

      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
      copy_on_select = "yes";

      strip_trailing_spaces = "smart";

      enable_audio_bell = "no";

      confirm_os_window_close = 0;

      window_margin_width = 0;
      window_border_width = "1.0";
      window_padding_width = 0;
      hide_window_decorations = "yes";
    };
    keybindings = {
      "kitty_mod+0" = "change_font_size all 0";
      "kitty_mod+equal" = "change_font_size all +1";
      "kitty_mod+minus" = "change_font_size all -1";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
    };
  };

  programs.alacritty.enable = true;
}
