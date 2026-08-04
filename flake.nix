{
  description = "Kore translation — LLM translation app built with Flutter";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      kore-translation = pkgs.callPackage ./package.nix {};
      default = kore-translation;
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = nixpkgs.lib.getExe self.packages.${system}.default;
      };
    });

    checks = forAllSystems (system: {
      inherit (self.packages.${system}) kore-translation;
    });

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          clang
          cmake
          flutter344
          jdk17
          ninja
          pkg-config
        ];
        buildInputs = with pkgs; [
          gtk3
          libsecret
        ];
      };
    });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
