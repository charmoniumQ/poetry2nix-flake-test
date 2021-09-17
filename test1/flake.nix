{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        name = "test1";
      in
        {
          packages.${name} = pkgs.poetry2nix.mkPoetryApplication {
            projectDir = ./.;
          };
          defaultPackage = self.packages.${system}.${name};
        }
    );
}
