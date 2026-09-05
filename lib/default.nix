{ nixpkgs, microvm }:
let
  capabilities = {
    osint = {
      identity = ../modules/capabilities/osint/identity.nix;
      domains = ../modules/capabilities/osint/domains.nix;
      metadata = ../modules/capabilities/osint/metadata.nix;
      web = ../modules/capabilities/osint/web.nix;
      geospatial = ../modules/capabilities/osint/geospatial.nix;
    };
    workspace.case-management = ../modules/capabilities/workspace/case-management.nix;
  };

  mkProfessionalLab = {
    system ? "x86_64-linux",
    id,
    title,
    description,
    capabilities ? [ ],
    modules ? [ ],
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit id title description; };
      modules = [
        microvm.nixosModules.microvm
        ../modules/base.nix
        {
          umbra.lab = { inherit id title description; };
        }
      ] ++ capabilities ++ modules;
    };
in {
  inherit mkProfessionalLab capabilities;
}
