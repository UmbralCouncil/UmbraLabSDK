{ lib, pkgs, ... }: {
  umbra.lab.capabilities = lib.mkAfter [ "osint.metadata" ];
  environment.systemPackages = with pkgs; [ exiftool file imagemagick mediainfo poppler-utils ];
}
