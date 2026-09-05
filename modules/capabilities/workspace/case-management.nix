{ lib, pkgs, ... }: {
  umbra.lab.capabilities = lib.mkAfter [ "workspace.case-management" ];
  environment.systemPackages = with pkgs; [ sqlite sqlitebrowser pandoc ];
  systemd.tmpfiles.rules = [
    "d /var/lib/umbra-workspace/cases 0750 operator users - -"
    "d /var/lib/umbra-workspace/evidence 0750 operator users - -"
    "d /var/lib/umbra-workspace/exports 0750 operator users - -"
  ];
}
