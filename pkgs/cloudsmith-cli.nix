{
  lib,
  stdenvNoCC,
  fetchurl,
}:

# nixpkgs-unstable still packages 1.9.4; fridge needs >= 1.20.0.
# Upstream now ships standalone binaries, so fetch those instead of
# trying to bump the old Python derivation.
stdenvNoCC.mkDerivation rec {
  pname = "cloudsmith-cli";
  version = "1.28.0";

  src = fetchurl {
    url = "https://github.com/cloudsmith-io/cloudsmith-cli/releases/download/v${version}/cloudsmith-${version}-macos-arm64.tar.gz";
    hash = "sha256-61lq8jx5ZeHJ+fQgqisG2Q+bJZsJV+OdHlN5XPM4AfE=";
  };

  sourceRoot = ".";

  dontStrip = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib $out/bin
    cp -R cloudsmith $out/lib/
    ln -s $out/lib/cloudsmith/cloudsmith $out/bin/cloudsmith
    ln -s $out/lib/cloudsmith/terraform-credentials-cloudsmith $out/bin/terraform-credentials-cloudsmith
    runHook postInstall
  '';

  meta = {
    description = "Cloudsmith Command Line Interface";
    homepage = "https://help.cloudsmith.io/docs/cli/";
    license = lib.licenses.asl20;
    mainProgram = "cloudsmith";
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
