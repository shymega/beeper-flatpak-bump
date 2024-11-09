{ fetchFromGitHub
, buildGoModule
, lib
}:
buildGoModule {
    pname = "beeper-flatpak-bump-ver";
    version = "0.1.0";

    src = lib.cleanSource ../../.;

    vendorHash = "sha256-6IJS9z7nQfoA0WSl7lrQhEf6KrqxsIwOgeR9js2Y88I=";

    meta = {
      description = "[UNOFFICIAL] A small utility for bumping the version of Beeper Desktop for Linux (x86_64 currently) in the Flatpak";
      homepage = "https://github.com/shymega/beeper-flatpak-bump-ver";
      license = lib.licenses.asl20;
      mainProgram = "beeper-flatpak-bump-ver";
    };
}
