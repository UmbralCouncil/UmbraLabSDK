{
  description = "My Umbra Professional lab";
  inputs.umbra-lab-sdk.url = "github:UmbralCouncil/UmbraLabSDK";
  outputs = { self, umbra-lab-sdk }:
    let
      system = "x86_64-linux";
      lab = umbra-lab-sdk.lib.mkProfessionalLab {
        inherit system;
        id = "my-lab";
        title = "My Lab";
        description = "A purpose-built Umbra security workstation.";
        modules = [ ./lab.nix ];
      };
    in {
      nixosConfigurations.default = lab;
      packages.${system}.default = lab.config.microvm.declaredRunner;
    };
}
