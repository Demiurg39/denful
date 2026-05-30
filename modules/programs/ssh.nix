{
  flake.modules.nixos.ssh = {
    # Harden SSH client
    programs.ssh = {
      # Known vulnerability. See
      # https://security.stackexchange.com/questions/110639/how-exploitable-is-the-recent-useroaming-ssh-vulnerability
      extraConfig = ''
        Host *
        UseRoaming no
      '';
    };
  };
}
