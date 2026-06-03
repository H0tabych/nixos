{
  config,
  lib,
  ...
}: {
  # Laptop-specific NVIDIA Prime configuration
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";

    # Offload режим (рекомендуется для ноутбуков)
    offload.enable = true;
    offload.enableOffloadCmd = true;
  };
}
