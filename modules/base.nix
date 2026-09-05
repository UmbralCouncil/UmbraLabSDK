{ config, lib, pkgs, ... }:
let
  cfg = config.umbra.lab;
  manifest = (pkgs.formats.json { }).generate "umbra-professional-lab.json" {
    schema = 1;
    kind = "professional-lab";
    inherit (cfg) id title description category capabilities;
    runtime = {
      inherit (cfg) network;
      memoryMiB = config.microvm.mem;
      vcpus = config.microvm.vcpu;
      hypervisor = config.microvm.hypervisor;
    };
  };
in {
  options.umbra.lab = {
    id = lib.mkOption { type = lib.types.strMatching "[a-z0-9][a-z0-9-]{0,63}"; };
    title = lib.mkOption { type = lib.types.nonEmptyStr; };
    description = lib.mkOption { type = lib.types.nonEmptyStr; };
    category = lib.mkOption { type = lib.types.str; default = "general"; };
    capabilities = lib.mkOption { type = lib.types.listOf lib.types.str; default = [ ]; };
    network = lib.mkOption {
      type = lib.types.enum [ "isolated" "controlled-egress" ];
      default = "isolated";
      description = "Network authority requested from the Studio supervisor.";
    };
  };

  config = {
    system.stateVersion = "26.05";
    networking.hostName = "umbra-${cfg.id}";
    networking.useDHCP = false;
    networking.firewall.enable = true;

    microvm = {
      hypervisor = "qemu";
      vcpu = lib.mkDefault 4;
      mem = lib.mkDefault 4096;
      interfaces = lib.mkForce [ ];
      shares = lib.mkForce [ ];
      storeOnDisk = true;
      writableStoreOverlay = "/nix/.rw-store";
      volumes = [{ mountPoint = "/var/lib/umbra-workspace"; image = "workspace.img"; size = 8192; }];
    };

    users.users.operator = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "umbra";
    };
    security.sudo.wheelNeedsPassword = false;
    services.getty.autologinUser = "operator";

    environment.systemPackages = with pkgs; [ bashInteractive coreutils curl git jq less ripgrep vim ];
    environment.etc."umbra/lab.json".source = manifest;
  };
}
