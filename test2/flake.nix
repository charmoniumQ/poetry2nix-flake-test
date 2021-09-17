{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    test1.url = "github:charmoniumQ/poetry2nix-flake-test?dir=test1";
  };
  outputs = { self, nixpkgs, flake-utils, test1 }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        name = "test2";
        name-shell = "${name}-shell";
      in
        {
          packages.${name-shell} = pkgs.mkShell {
            buildInputs = [
              test1
            ];
          };
          devShell = self.packages.${system}.${name-shell};
        }
    );
}
