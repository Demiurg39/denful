{inputs, ...}: {
  flake.homeConfigurations =
    (inputs.self.lib.mkHome {
      username = "demi";
      profile = "default";
    })
    // (inputs.self.lib.mkHome {
      username = "demi";
      profile = "cli";
    })
    // (inputs.self.lib.mkHome {
      username = "demi";
      profile = "desktop";
    });
}
