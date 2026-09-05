{ lib, pkgs, ... }: {
  umbra.lab = {
    category = "osint";
    network = "isolated";
  };
  microvm = { mem = 6144; vcpu = 4; };
  environment.systemPackages = with pkgs; [ firefox-esr keepassxc ];
  environment.etc."umbra/profile".text = ''
    OSINT Workbench
    Network access is disabled until Studio grants a controlled-egress policy.
    Store cases under /var/lib/umbra-workspace/cases.
  '';
}
