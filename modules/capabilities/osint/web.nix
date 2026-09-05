{ lib, pkgs, ... }: {
  umbra.lab.capabilities = lib.mkAfter [ "osint.web" ];
  environment.systemPackages = with pkgs; [ chromium httpie wget wget2 yt-dlp ];
}
