{ lib, pkgs, ... }: {
  umbra.lab.capabilities = lib.mkAfter [ "osint.domains" ];
  environment.systemPackages = with pkgs; [ bind whois amass subfinder ];
}
