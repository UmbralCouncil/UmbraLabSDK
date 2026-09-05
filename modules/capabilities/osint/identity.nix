{ lib, pkgs, ... }: {
  umbra.lab.capabilities = lib.mkAfter [ "osint.identity" ];
  environment.systemPackages = with pkgs; [ maigret sherlock ];
}
