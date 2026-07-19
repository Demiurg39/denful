{config, inputs, ...}: {
  flake.modules.nixos.delphi = {
    imports = [inputs.self.modules.nixos.cloudflared];
    age.secrets."delphi.wundertunnel_token".rekeyFile = "${inputs.secrets}/hosts/delphi/wundertunnel_token.age";
    services.cloudflared = {
      tunnels = {
        "65dfe604-c867-4aba-9bba-93f0e122ae08" = {
          credentialsFile = config.age.secrets."delphi.wundertunnel_token".path;
          # default = "";
          ingress = {
            "vault.${inputs.self.const.domain}/notification/hub" = "http://localhost:3012";
            "vault.${inputs.self.const.domain}/notification/hub/negotiate" = "http://localhost:8222";
            "vault.${inputs.self.const.domain}" = "http://localhost:8222";
            # "cloud.${inputs.self.const.domain}" = "http://localhost:8080";
            # "photos.${inputs.self.const.domain}" = "http://localhost:8080";
            # "search.${inputs.self.const.domain}" = "http://localhost:8080";
            # "todo.${inputs.self.const.domain}" = "http://localhost:8080";
            # "budget.${inputs.self.const.domain}" = "http://localhost:8080";
            # "atuin.${inputs.self.const.domain}" = "http://localhost:8080";
          };
        };
      };
    };
  };
}
