{
  self,
  lib,
  ...
}: {
  config.flake.factory.user = username: isAdmin: {
    nixos."${username}" = {
      users.users."${username}" = {
        name = "${username}";
        home = "/home/${username}";
        extraGroups = lib.optionals isAdmin ["wheel"];
      };

      home-manager.users."${username}" = {
        imports = [self.modules.homeManager."${username}"];
      };
    };

    homeManager."${username}" = {
      home.username = "${username}";
    };
  };
}
