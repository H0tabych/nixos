# ~/nixos-config/home-manager/sgm/programs/mangohud.nix
{ config, pkgs, ... }:

{
  home.file.".config/MangoHud/MangoHud.conf".text = ''
    # Основные настройки отображения
    fps
    gpu_stats
    cpu_stats
    ram
    vram
    engine_version
    frame_timing
    latency
    throttling_status
    battery
    log_duration

    # Расположение на экране
    position = top-left
    text_outline
    background_alpha = 0.6
    font_size = 24
  '';
}
