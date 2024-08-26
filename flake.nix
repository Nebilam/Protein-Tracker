
{
  description = "anki-dart";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:

    let
      
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs { 
        inherit system; 
        config = {
          # android_sdk.accept_license = true;
          allowUnfree = true; 
        }; 
      };
      # androidSdk = pkgs.androidenv.androidPkgs_9_0.androidsdk;
    in
    {
      devShells.${system}.default =
        # let
        #   android = pkgs.callPackage ./nix/android.nix { };
        # in
        pkgs.mkShell 
        { 
          buildInputs = with pkgs; [
            # dart
            flutter
            # androidSdk # FIXME android-tools?
            # android-tools # NOTE adb, ...?
            # android-studio-full # NOTE full = with android sdk?
            # jdk17

            # android.platform-tools
          ];
          shellHook = ''
            echo "devShell activated"
            '';

          # NOTE environment variables
          # ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          # CHROME_EXECUTABLE = pkgs.firefox
          # ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
          # JAVA_HOME = pkgs.jdk17;
          # ANDROID_AVD_HOME = (toString ./.) + "/.android/avd";
        };
  };
}