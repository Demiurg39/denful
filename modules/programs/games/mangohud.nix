{
  flake.modules.homeManager.mangohud = {
    programs.mangohud = {
      enable = true;
      settings = {
        legacy_layout = false;
        horizontal = true;
        hud_no_margin = true;
        font_size = 14;
        background_alpha = "0.4";
        round_corners = 5;

        cpu_stats = true;
        cpu_temp = true;
        cpu_power = true;
        cpu_mhz = true;

        gpu_stats = true;
        gpu_temp = true;
        gpu_core_clock = true;
        gpu_power = true;
        gpu_mem_clock = true;

        ram = true;
        vram = true;
        fps = true;
        frametime = true;
        toggle_hud = "Shift_R+F12";
      };
    };
  };
}
