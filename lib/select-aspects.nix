{lib}: {
  aspects,
  nixosRegistry,
  homeManagerRegistry ? {},
}: let
  inNixos = n: builtins.hasAttr n nixosRegistry;
  inHomeManager = n: builtins.hasAttr n homeManagerRegistry;

  missing = builtins.filter (n: !(inNixos n || inHomeManager n)) aspects;

  nixosModules = lib.concatMap (n:
    if inNixos n
    then [nixosRegistry.${n}]
    else [])
  aspects;
  homeManagerModules = lib.concatMap (n:
    if inHomeManager n
    then [homeManagerRegistry.${n}]
    else [])
  aspects;
in (
  if missing != []
  then throw "Unknown aspect(s): ${builtins.concatStringsSep ", " missing}"
  else {
    nixos = nixosModules;
    homeManager = homeManagerModules;
  }
)
