{
  flake.modules.nixos.demi = {
    home-manager.users.demi = {
      programs.git.settings = {
        user.email = "chiryagov2014@gmail.com";
        user.name = "demiurg39";
      };
    };
  };
}
