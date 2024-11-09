{
  description = "[UNOFFICIAL] A small utility for bumping the version of Beeper Desktop for Linux (x86_64 currently) in the Flatpak";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      goVersion = 23;

      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default.${system} ];
        };
      });
    in
    {
      overlays.default = forEachSupportedSystem ({ pkgs }:
        final: _: {
        go = final."go_1_${toString goVersion}";
        inherit (self.packages.${final.system}) beeper-flatpak-bump-ver;
      });

      packages = forEachSupportedSystem ({ pkgs }: with pkgs; rec {
        default = beeper-flatpak-bump-ver;
        beeper-flatpak-bump-ver = callPackage ./build-aux/nix { };
      });

      apps = forEachSupportedSystem ({ pkgs }: with pkgs; rec {
        default = {
          type = "app";
          program = lib.getExe self.packages.${system}.beeper-flatpak-bump-ver;
        };
      });

      devShells = forEachSupportedSystem ({ pkgs }: with pkgs; {
        default = mkShell {
          packages = [
            # go (version is specified by overlay)
            go

            # goimports, godoc, etc.
            gotools

            # https://github.com/golangci/golangci-lint
            golangci-lint
          ] ++ self.packages.${pkgs.system}.default.buildInputs
            ++ self.packages.${pkgs.system}.default.nativeBuildInputs;
        };
      });
    };
}
