{lib, ...}: {
  options.displaySpec = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Display name";
    };

    resolution = lib.mkOption {
      type = lib.types.str;
      description = "Display resolution";
      example = "1920x1080";
    };

    refreshRate = lib.mkOption {
      type = lib.types.str;
      description = "Display refresh rate";
    };
  };
}
