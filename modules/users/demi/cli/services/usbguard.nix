{inputs, ...}: {
  flake.modules.nixos.demi-cli = {
    imports = [inputs.self.modules.nixos.usbguard];
    services.usbguard.rules = ''
      allow id 1d6b:0002 name "xHCI Host Controller" hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" parent-hash "ldMchY4Tt4GPUYo30eNGvai+Fs/EdnVY3vMyxJUq4Nk=" with-interface 09:00:00 with-connect-type ""
      allow id 04e8:6864 name "SAMSUNG_Android" hash "JorMk9jefVHgGXcW80VUeHb61ECb3Kt4AgmK4U/Pq5U=" parent-hash "TaKoMrgQrk94nyzpOQk+iNVB0H+ZSnYN/X7lY+QzAn0="
    '';
  };
}
