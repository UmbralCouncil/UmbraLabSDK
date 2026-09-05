{ nixpkgs, microvm }:
let
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
  inherit mkProfessionalLab;
  schemas = {
    labV1 = ../schema/lab-v1.schema.json;
    registryV1 = ../schema/registry-v1.schema.json;
  };
}
