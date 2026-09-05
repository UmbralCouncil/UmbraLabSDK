{ lib, pkgs, ... }: {
  umbra.lab.capabilities = lib.mkAfter [ "osint.geospatial" ];
  environment.systemPackages = with pkgs; [ exiftool geos gdal qgis ];
}
