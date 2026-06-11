{inputs, ...}: {
  flake.modules.nixos.asura = {
    imports = [inputs.self.modules.nixos.usbguard];
    services.usbguard.rules = ''
      allow id 1d6b:0002 name "xHCI Host Controller" hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" parent-hash "ldMchY4Tt4GPUYo30eNGvai+Fs/EdnVY3vMyxJUq4Nk=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 name "xHCI Host Controller" hash "d+DNGWARDtv9nEK2ZvnNOCtFernuMu5/e/oZ7kCppqQ=" parent-hash "ldMchY4Tt4GPUYo30eNGvai+Fs/EdnVY3vMyxJUq4Nk=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 name "xHCI Host Controller" hash "icotY3rI59mWiKsGxc59BGZZeBjfbuH0b4NUByj3cbQ=" parent-hash "tHvBfznK5rpQn+oa0PEEjHa29EAEvGyCcZixsfwA6W0=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 name "xHCI Host Controller" hash "UbEoCZW8HT2ldc3qDeiK+IiQlGeaBC7F63681OwmKhI=" parent-hash "tHvBfznK5rpQn+oa0PEEjHa29EAEvGyCcZixsfwA6W0=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 name "xHCI Host Controller" hash "ryHCmG3nsLVuHD/YMplTUyPWzK2YMO368ASLReR84VQ=" parent-hash "O2mjuPcd9LTYYlzbl7Ur3X1/6UFFvO71xarwno0+5kk=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 name "xHCI Host Controller" hash "+0s5mKAEDBjZasKfFR9ExKfjpMr/J4C4yq4bgYdLJSM=" parent-hash "bJaC8Jzo7aUv8jJa4QLtZLwybCJrJPivPWQkpA7PZ70=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 name "xHCI Host Controller" hash "OOTFv0DuAPoWzkjfh1FRhwu95L3mbMj68cvWj70EeKY=" parent-hash "bJaC8Jzo7aUv8jJa4QLtZLwybCJrJPivPWQkpA7PZ70=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 name "xHCI Host Controller" hash "TaKoMrgQrk94nyzpOQk+iNVB0H+ZSnYN/X7lY+QzAn0=" parent-hash "53F8MTi5nK85FrmZKoXL73EAIxPsMA4OAWgUI+Dn0zY=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 name "xHCI Host Controller" hash "QzrRAozgfdIv/GTYHZFIOzaNz+OGgEdvSZ1/xhyj18s=" parent-hash "53F8MTi5nK85FrmZKoXL73EAIxPsMA4OAWgUI+Dn0zY=" with-interface 09:00:00 with-connect-type ""
      allow id 2b7e:b685 name "USB2.0 HD UVC WebCam" hash "AX1FGK8yutRDXef9HUowGA1+sH+1rMqPvV4oU6RMHns=" parent-hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" via-port "1-4" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 } with-connect-type "not used"
      allow id 13d3:3563 name "Wireless_Device"      hash "+N1T4yj/1lqXO4lVyxUKJB4BArSjXUzt8PhlcM1+oCc=" parent-hash "icotY3rI59mWiKsGxc59BGZZeBjfbuH0b4NUByj3cbQ=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "not used"
    '';
  };
}
