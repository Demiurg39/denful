{lib, ...}: {
  config.flake.lib = rec {
    # Extract XDG App ID (.desktop filename) from a Nix package dynamically
    getMime = pkg:
      if builtins.isAttrs pkg
      then
        "${pkg}/share/applications"
        |> (dir:
          if builtins.pathExists dir
          then builtins.readDir dir
          else {})
        |> builtins.attrNames
        |> builtins.filter (lib.hasSuffix ".desktop")
        |> (files:
          if files == []
          then "${pkg.pname or pkg.name}"
          else builtins.head files)
      else pkg;

    assoc = program: mimeMap:
      mimeMap
      |> lib.mapAttrsToList (
        mime: exts:
          map (ext: {
            name = "${mime}/${ext}";
            value = getMime program;
          })
          exts
      )
      |> builtins.concatLists
      |> builtins.listToAttrs;
  };
}
