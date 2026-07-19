{lib, ...}: {
  options.flake.const = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.const = {
    timezone = "Asia/Bishkek";
    domain = "diewunderwelt.dpdns.org";
  };
}
