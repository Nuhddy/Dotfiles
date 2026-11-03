{
  flake.modules.generic.options = {lib, ...}: {
    options.my = {
      display = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Display name.";
        };
        scale = lib.mkOption {
          type = lib.types.either lib.types.numbers.positive (lib.types.enum ["auto"]);
          default = "auto";
          description = "Display scale: one of any positive number or auto";
        };
        vrr = lib.mkOption {
          type = lib.types.enum [(-1) 0 1 2 3];
          default = 0;
          description = "Variable refresh rate in hyprland format: one of -1, 0, 1, 2, 3.";
        };
      };
    };
  };
}
