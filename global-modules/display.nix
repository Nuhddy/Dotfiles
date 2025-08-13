{lib, ...}: {
  options.hostSpec.display = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Display name";
    };

    resolution = lib.mkOption {
      type = lib.types.str;
      default = "1920x1080";
      description = "Display resolution";
      example = "1920x1080";
    };

    refreshRate = lib.mkOption {
      type = lib.types.str;
      default = "60";
      description = "Display refresh rate";
    };
  };
}
