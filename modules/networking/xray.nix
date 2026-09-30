{ pkgs, config, ... }:
let
  # ВАЖНО: Подставьте сюда mldsa65Verify (pqv) из вашей vless:// ссылки
  mldsa65Verify = "JeSvaNQy_i5WzR5m47NSzWsEl63aJLgvtymF0C5pZGV7Wgv-BCkeH4d1_wS0MdjSI0tDlbUiFaTeeSxd6td-f0q8rmhcBLg7hRJWH7811ff7pNC1GS2tQWp3QxjBIx7qNeBa5hrK0jITQcSCCAxnzQwnAHIkzCwXcBtCGWX9btNVyAF8d2FvrbNYfjgdHiO8YVpSyM7C782CW9xsOCqf3wrpSKYE3orC8nOOxV-FNkQfRQJt_zhlDzg5DU3GYV2PPV5YvNW-VXAujTrljZx3qwzX8SP0enFsCEBBA49TRX5tbYKx5lalntqV9QfzYCScE9-K7Cv4UW_1-W_dH35CJ2aU-vwM6L8HWI9P8JBZ80PGQzHrLk2M7sblKlAHTN4Tr2m52z1_MS9y5eZ0UQUo4DBSSMtGsQEQrEls_RXNIMwTJ8nSS1rao4b4NgnoDYFHbRc2rThfpdNyWlzSIXZPp2kHjDQWvaIzGRSyuzHn5b6dSw2pdqpy5IkD8j4657XyvVOyBKECCdhA2jnXCVynrViGvnamJIzWwXmBBW7jt4XZniuGJeJUf6l_l-7dESeRGNThzsdF5I5L_Nb28EP_Q-CiIMXl0yRcfoxfBPNvOKTVk37ua9XW8GB3l6dBejKZKUpbCXjCVtPxfarjQb9LuERIUzfxU21eUKWPWHEVktNShO4FbRv_meviOkkckgV3kNoz9BOOyXVDO5Mw7wiqAaP5CT69xQOwNpbhUF72gLKCZGNuXqv5xb1_MJ8PWtzPd-UUZySOXpQuKeEHDy2Ijlm4obbItBOCuXVDjcdh5_96MVCvl24exHPLK5iJnDnrB7_1q0k6J5AA3hTe0I-6qhs9MrtjSn9D0ZgidXVcWoU17-H0KWVxUtmkv079lWXGRk7oT4d6BUgF27YN1cCn1A4f5cXsnnrK8w1gXZcDdsQPLVn3BCxr2bG1YIgh-7v-FHr0bRYpwu_jOVxhaZKVvlfXEgWufpHkPXwcAfWgN6aoEpOwEvw0L8XWbwg37RuP7WKstWpPPkyIxlWF77CI4hTopI8G-1ODCWpllK3FDPNMho5IuQWivuUNPdQO3p62qHZdFnlvBK9rT-OYXiUyDDYj36wdpeIYLNeycQ6qO5sw6b9FSw_ICIdxllB6-XzzKqSnt-bJ5hzCnaPVw7kES80opGdOakEKt_ZDDiScKMpR0Yd_w31XaAfa3QcsG1fykW-XpOpC3n6RGE3f7AYpQlQqlx8-dHIlg4bmEZdNGshXnoU_zat91aOfDe961XMefiurIXNoaaQzVqCG4PErbdUeqNhYDj1d0eIfUTXPDCQbZO1VPnavIzeN_UlgkhhAzKBuEMGiK2Jb_T2r0zAIsR-kJAb86quCkf0H7DQdQKOSEbQa3yk3FqmbMoFKtvsEhehNPad_PH7qjbQOzRw0Ynpodky_NZgdunlqnr5jHfKh6G8RhDTwoi_XwJUZLOfS-ouaf0x5pUL-Y7svlUwzYagHfS33baL7SBC3u2snfCKfsxHf-U-TGTqOJmLKFck7LQC0Agk3zEz35bEEyVe1oL2ccwDmGsLp_IIv3_HNS8POUhYQoRF6SDYgFUl9a-vVPOtkppDCoiJEf98S-BEOEWZHFN50muxzoZuzLt-4E_1BDDzKLMazj4OXtaVo66yxuK_gv1k1mjN4BytfobwiDk1xfxDqygPaho_sRWVwQGg6sgcvecinnIpenKK9xjlWkjRCc4bz3NfzC-hB0FQVNaOIOWZBzNFnwQbbuWsgRkHXn7YnXmyKV7Fz_R3jnMHpkvRIrfuF8dzb15efNjs43QBBlapCDQYYS1H2cndGlQqKd2-vjLBN5Th1Xinuhg6JL8oap9lrR2lMyeES7G9DhFiNonspS61PFSrSD7ShiY1yQHIlz-8qJFqBH6XDUUA6fo7B9HHWlbROgZiCmTPAojJix8OmHgF4u74Bi2cgNe9W4aAdlXKWRxtpgbBmydXHFVRynnVRjSQDfsggGdI-DAO61aXQspOoooTxxyQXugQN-M-qeROIcBgVVQL1kacH3029-NHDRQN5YesfXJbfjlLC7zXaaaSN0GdpMhCyoDDJ1IJEd7gY9MlK0RUtFT8KvE2bp-2DOOmBJ5wa51Tr2UIyxFEwN_8iQ8-Jm2GL6ibyKCkM9LS7eVYxEZKcnFuiG6r-dJqQQjr75qVQbFwlKuJj74qDnBZ8CLPS-B9Q1XwDigCMQ6qFMTiA0KFQzwMvkhQuD5f_NVyjWNFF59NgVoboajtXh4ZLKnIQOIqjd9Mh6o3fNJBcl_f2Qk8IGafMUNPIpSoUjR1iCmgUMJtDbHRLTS6g0K3WtqJTbXTJBYDr3EU0pP8wJTNWVueIUXKG4bMR4TrYlDqBLR2y3VcklBDRURbrOtzP5D692ixwtFmJIhO7cfMSt5qEu88MOx7RNi96Q61DG1KvFUkeInXfHEQJFxuMMhr3D2yht-_5PvDAPMfQqSOtkPRFz3chPrNF3KGAfdwUmSZyUq-sABrLvB-8fcb2-kqx_8EgNWJ1n-8UDofrcX-ZEVnMBWNS5wg4iQylYVOgs-agVGG_Fj91Xsgt9BFfY0VzBe0p91vot-o";
  
  xrayConfig = {
    log = { loglevel = "warning"; };
    
    # 1. DNS-секция — КЛЮЧЕВОЕ исправление для скорости
    dns = {
      servers = [
        # Российские домены резолвим через Yandex DNS (быстро, без подмен)
        {
          address = "77.88.8.8";
          domains = [ "geosite:category-ru" "domain:ru" "domain:su" "domain:xn--p1ai" ];
        }
        # Все остальные — через DoH (пойдёт через прокси в Финляндию)
        "https://1.1.1.1/dns-query"
        "https://8.8.8.8/dns-query"
      ];
      queryStrategy = "UseIPv4"; # Избегаем проблем с IPv6 у хостера
    };
    
    # 2. Инбаунды — только localhost для безопасности
    inbounds = [
      {
        tag = "socks-in";
        listen = "127.0.0.1";  # ← ИСПРАВЛЕНО: было 0.0.0.0
        port = 10808;
        protocol = "socks";
        settings = { udp = true; auth = "noauth"; };
        sniffing = { enabled = true; destOverride = [ "http" "tls" ]; };
      }
      {
        tag = "http-in";
        listen = "127.0.0.1";  # ← ИСПРАВЛЕНО: было 0.0.0.0
        port = 10809;
        protocol = "http";
        settings = { };
      }
    ];

    # 3. Исходящие соединения
    outbounds = [
      {
        tag = "proxy";
        protocol = "vless";
        settings = {
          vnext = [{
            address = "45.118.249.196";
            port = 443;
            users = [{
              id = "14beb278-c5f7-484e-a62d-f45ab10d8145";
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
            publicKey = "YJww_aS21uwTAE4uXGBOvgfLa-wN9oAGOrZuSdzXqSo"; # ← Подставьте из vless:// ссылки
            shortId = "e8"; # ← Позже заменим на 8+ hex символов
            fingerprint = "chrome";
            spiderX = "/"; # ← ДОБАВЛЕНО: защита от активного пробинга
            mldsa65Verify = mldsa65Verify; # ← ДОБАВЛЕНО: постквантовая проверка
          };
        };
      }
      { tag = "direct"; protocol = "freedom"; }
      { tag = "block"; protocol = "blackhole"; }
    ];

    # 4. Умная маршрутизация с явным catch-all
    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        # Локальные сети напрямую
        { type = "field"; ip = [ "geoip:private" ]; outboundTag = "direct"; }
        
        # Российский трафик напрямую (через Yandex DNS)
        { type = "field"; domain = [ "geosite:category-ru" ]; outboundTag = "direct"; }
        { type = "field"; ip = [ "geoip:ru" ]; outboundTag = "direct"; }
        
        # Реклама блокируется
        { type = "field"; domain = [ "geosite:category-ads-all" ]; outboundTag = "block"; }
        
        # ← ДОБАВЛЕНО: Явный catch-all для всего остального
        { type = "field"; network = "tcp,udp"; outboundTag = "proxy"; }
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
      ExecStart = "${pkgs.xray}/bin/xray -c /etc/xray/client.json";
      # НЕ задаём XRAY_LOCATION_ASSET — wrapper внутри pkgs.xray делает это сам
      Restart = "always";
      RestartSec = 5;
      User = "nobody";
      ProtectSystem = "strict";
      ProtectHome = "yes";
      PrivateTmp = "yes";
    };
  };
}
