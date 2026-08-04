{
  copyDesktopItems,
  flutter344,
  gtk3,
  jdk17,
  lib,
  libsecret,
  makeDesktopItem,
  stdenv,
}: let
  unmodifiedPubSource = {
    src,
    version,
    ...
  }:
    stdenv.mkDerivation {
      pname = "pub-source";
      inherit src version;
      inherit (src) passthru;

      installPhase = ''
        cp -r "$src" "$out"
      '';
    };
in
  flutter344.buildFlutterApplication {
    pname = "kore-translation";
    version = "0.1.6";

    src = lib.cleanSource ./.;
    pubspecLock = lib.importJSON ./pubspec.lock.json;

    customSourceBuilders = {
      # These EOL packages contain no native implementation and only remain in
      # the lockfile through development dependencies.
      sqlcipher_flutter_libs = unmodifiedPubSource;
      sqlite3_flutter_libs = unmodifiedPubSource;
    };

    nativeBuildInputs = [copyDesktopItems];

    buildInputs = [
      gtk3
      jdk17
      libsecret
    ];

    postInstall = ''
      install -Dm644 macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png \
        $out/share/icons/hicolor/512x512/apps/kore-translation.png
    '';

    desktopItems = [
      (makeDesktopItem {
        name = "kore-translation";
        exec = "kore_translation";
        icon = "kore-translation";
        desktopName = "Kore翻訳";
        genericName = "LLM translation app";
        categories = ["Utility"];
        startupWMClass = "dev.kore.kore_translation";
      })
    ];

    meta = {
      description = "LLM translation app built with Flutter";
      homepage = "https://github.com/fa0311/kore-translation";
      mainProgram = "kore_translation";
      platforms = lib.platforms.linux;
    };
  }
