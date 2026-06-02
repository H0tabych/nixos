# ~/nixos-config/hosts/sgms-laptop/hardware.nix
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Информация о файловых системах (сгенерирована автоматически)
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7d684e3f-6df9-4a1d-a44a-ec1617976d1e";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7d684e3f-6df9-4a1d-a44a-ec1617976d1e";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/7d684e3f-6df9-4a1d-a44a-ec1617976d1e";
    fsType = "btrfs";
    options = [ "subvol=@nix" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/7d684e3f-6df9-4a1d-a44a-ec1617976d1e";
    fsType = "btrfs";
    options = [ "subvol=@persist" ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/7d684e3f-6df9-4a1d-a44a-ec1617976d1e";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4AE4-A75A";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # Swap-устройства: здесь пусто, т.к. мы подключаем swap-файл в system.nix
  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
