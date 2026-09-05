{
  description = "Umbra Professional Lab SDK — reproducible modular security workstations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, microvm }:
    let
      system = "x86_64-linux";
      sdk = import ./lib { inherit nixpkgs microvm; };
      pkgs = import nixpkgs { inherit system; };
    in {
      lib = sdk;

      nixosModules = {
        lab-base = import ./modules/base.nix;
      };

      packages.${system} = {
        default = self.packages.${system}.lab-registry;
        lab-registry = pkgs.runCommand "umbra-public-lab-registry" { } ''
          install -Dm644 ${./registry/labs.json} $out/registry.json
        '';
      };

      checks.${system} = {
        lab-registry = pkgs.runCommand "lab-registry-check" {
          nativeBuildInputs = [ pkgs.check-jsonschema ];
        } ''
          check-jsonschema --schemafile ${./schema/registry-v1.schema.json} ${./registry/labs.json}
          touch $out
        '';
      };

      templates.default = {
        path = ./templates/professional-lab;
        description = "A modular Umbra Professional lab";
      };
      templates.professional-lab = self.templates.default;
    };
}
