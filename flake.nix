{
  description = "Umbra Professional Lab SDK — reproducible modular security workstations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, microvm }:
    let
      system = "x86_64-linux";
      sdk = import ./lib { inherit nixpkgs microvm; };
      osintLab = sdk.mkProfessionalLab {
        inherit system;
        id = "osint-workbench";
        title = "OSINT Workbench";
        description = "A modular workstation for lawful open-source intelligence investigations.";
        capabilities = with sdk.capabilities; [
          osint.identity
          osint.domains
          osint.metadata
          osint.web
          osint.geospatial
          workspace.case-management
        ];
        modules = [ ./profiles/osint.nix ];
      };
      pkgs = import nixpkgs { inherit system; };
    in {
      lib = sdk;

      nixosModules = {
        lab-base = import ./modules/base.nix;
      };

      nixosConfigurations.osint-workbench = osintLab;

      packages.${system} = {
        default = osintLab.config.microvm.declaredRunner;
        osint-workbench = osintLab.config.microvm.declaredRunner;
        osint-manifest = osintLab.config.environment.etc."umbra/lab.json".source;
      };

      checks.${system}.osint-manifest = pkgs.runCommand "osint-manifest-check" {
        nativeBuildInputs = [ pkgs.check-jsonschema ];
      } ''
        check-jsonschema --schemafile ${./schema/lab-v1.schema.json} ${self.packages.${system}.osint-manifest}
        touch $out
      '';

      templates.default = {
        path = ./templates/professional-lab;
        description = "A modular Umbra Professional lab";
      };
      templates.professional-lab = self.templates.default;
    };
}
