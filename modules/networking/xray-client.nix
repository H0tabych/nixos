{ pkgs, config, ... }:
let
  xrayConfig = {
    log = { loglevel = "warning"; };
    inbounds = [
      {
        port = 10808;
        protocol = "socks";
        settings = { udp = true; auth = "noauth"; };
        sniffing = { enabled = true; destOverride = [ "http" "tls" ]; };
      }
      {
        port = 10809;
        protocol = "http";
        settings = { auth = "noauth"; };
      }
    ];
    outbounds = [
      {
        tag = "proxy";
        protocol = "vless";
        settings = {
          vnext = [{
            address = "45.118.249.196"; # Ваш IP
            port = 443;
            users = [{
              id = "14beb278-c5f7-484e-a62d-f45ab10d8145"; # Ваш ID
              encryption = "none";
              flow = "xtls-rprx-vision";
            }];
          }];
        };
        streamSettings = {
          network = "tcp";
          security = "reality";
          realitySettings = {
            serverName = "www.microsoft.com";
            publicKey = "YJww_aS21uwTAE4uXGBOvgfLa-wN9oAGOrZuSdzXqSo"; # <-- Обязательно подставьте pbk из vless:// ссылки
            shortId = "e8";
            fingerprint = "chrome";
          };
        };
      }
      { tag = "direct"; protocol = "freedom"; }
      { tag = "block"; protocol = "blackhole"; }
    ];
    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        { type = "field"; ip = [ "geoip:private" ]; outboundTag = "direct"; }
        { type = "field"; domain = [ "geosite:category-ru" ]; outboundTag = "direct"; }
        { type = "field"; ip = [ "geoip:ru" ]; outboundTag = "direct"; }
        { type = "field"; domain = [ "geosite:category-ads-all" ]; outboundTag = "block"; }
      ];
    };
  };
in {
  environment.systemPackages = [ pkgs.xray ];

  environment.etc."xray/client.json".text = builtins.toJSON xrayConfig;

  systemd.services.xray-client = {
    description = "Xray Post-Quantum Reality Client";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      # Wrapper внутри pkgs.xray сам настроит XRAY_LOCATION_ASSET на базы данных
      ExecStart = "${pkgs.xray}/bin/xray -c /etc/xray/client.json";
      
      Restart = "always";
      RestartSec = 5;
      User = "nobody";
      
      ProtectSystem = "strict";
      ProtectHome = "yes";
      PrivateTmp = "yes";
    };
  };
}
