{lib, ...}: {
  options.hostSpec.display = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Display name";
    };

    width = lib.mkOption {
      type = lib.types.int;
      default = 1920;
      description = "Display resolution width";
      example = 1920;
    };

    height = lib.mkOption {
      type = lib.types.int;
      default = 1080;
      description = "Display resolution height";
      example = 1080;
    };

    refreshRate = lib.mkOption {
      type = lib.types.int;
      default = 60;
      description = "Display refresh rate";
    };
  };
}
