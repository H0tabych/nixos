# ~/nixos-config/home-manager/sgm/programs/media.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv               # Видеоплеер
    swayimg           # Просмотрщик изображений
    yt-dlp            # Загрузка видео (часто используется с mpv)
  ];

  # Конфигурация mpv
  xdg.configFile."mpv/mpv.conf".text = ''
    vo=gpu-next
    hwdec=auto-safe
    profile=gpu-hq
    scale=ewa_lanczossharp
    cscale=ewa_lanczossharp
    video-sync=display-resample
    interpolation
    tscale=oversample
    audio-channels=2
    volume=100
    volume-max=200
  '';
}
