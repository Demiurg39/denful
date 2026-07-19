{inputs, ...}: {
  flake.modules.nixos.delphi = {config, ...}: {
    imports = [inputs.self.modules.nixos.cloudflared];
    age.secrets."delphi.wundertunnel_creds".rekeyFile = "${inputs.secrets}/hosts/delphi/wundertunnel_creds.age";
    services.cloudflared = {
      tunnels = {
        "65dfe604-c867-4aba-9bba-93f0e122ae08" = {
          credentialsFile = config.age.secrets."delphi.wundertunnel_creds".path;
          default = "http_status:505";
          originRequest = {
            noHappyEyeballs = true;
            disableChunkedEncoding = true;
          };
        };
      };
    };
  };
}
