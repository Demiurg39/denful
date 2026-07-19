{inputs, ...}: {
  # FIX: home-manager standalone cause stateVersion error
  # flake.homeConfigurations = inputs.self.lib.mkHome "x86_64-linux" "demi";
  # flake.homeConfigurations = inputs.self.lib.mkHome "aarch64-linux" "demi";
}
