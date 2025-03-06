{config, ...}: {
  configSymlink = relPath: config.lib.file.mkOutOfStoreSymlink ("/home/nuhddy/.config/nixos/configs/" + relPath);
}
