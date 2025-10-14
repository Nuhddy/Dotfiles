{...}: {
  programs.swaylock = {
    enable = true;
    settings = {
      image = ../../assets/wallpaper.png;
      scaling = "fill";
      show-keyboard-layout = false;
    };
  };
}
