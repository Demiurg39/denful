{inputs, ...}: {
  flake.modules.nixos.delphi = {config, ...}: {
    imports = [inputs.self.modules.nixos.vaultwarden];
    age.secrets."delphi.vaultwarden_env".rekeyFile = "${inputs.secrets}/hosts/delphi/vaultwarden_env.age";

    services.vaultwarden = {
      dbBackend = "postgresql";
      configurePostgres = true;
      # dbBackend = "mysql";
      # environmentFile = config.age.secrets."delphi.vaultwarden_env".path;
      domain = "https://vault.${inputs.self.const.domain}";

      config = {
        SIGNUPS_ALLOWED = false;

        # ROCKET_ADDRESS = "127.0.0.1";
        # ROCKET_PORT = 8222;
        #
        # WEB_VAULT_ENABLED = true;
        # WEBSOCKET_ENABLED = true;
        # WEBSOCKET_PORT = 3012;
        #
        # SMTP_HOST = "smtp.email.eu-amsterdam-1.oci.oraclecloud.com";
        # SMTP_FROM = "noreply@${inputs.self.const.domain}";
        # SMTP_PORT = 587;
        # SMTP_SECURITY = "starttls";
        #
        # PUSH_ENABLED = true;
        # PUSH_RELAY_URI = "https://api.bitwarden.eu";
        # PUSH_IDENTITY_URI = "https://identity.bitwarden.eu";

        DATABASE_MAX_CONNS = 10;
      };
    };
  };
}
