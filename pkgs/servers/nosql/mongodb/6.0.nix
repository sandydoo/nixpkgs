{
  stdenv,
  callPackage,
  fetchpatch,
  sasl,
  boost,
  cctools,
  avxSupport ? stdenv.hostPlatform.avxSupport,
}:

let
  buildMongoDB = callPackage ./mongodb.nix {
    inherit
      sasl
      boost
      cctools
      stdenv
      ;
  };
in
buildMongoDB {
  inherit avxSupport;
  version = "6.0.24";
  sha256 = "sha256-5Ip7uulbdb1rTzDWkPQjra035hA01bltPfvqnTm3tDw=";
  patches = [
    # Patches a bug that it couldn't build MongoDB 6.0 on gcc 13 because a include in ctype.h was missing
    ./fix-gcc-13-ctype-6_0.patch

    (fetchpatch {
      name = "mongodb-6.1.0-rc-more-specific-cache-alignment-types.patch";
      url = "https://github.com/mongodb/mongo/commit/5435f9585f857f6145beaf6d31daf336453ba86f.patch";
      sha256 = "sha256-gWlE2b/NyGe2243iNCXzjcERIY8/4ZWI4Gjh5SF0tYA=";
    })

    # Fix building with python 3.12 since the imp module was removed
    ./mongodb-python312.patch
  ];
  # passthru.tests = { inherit (nixosTests) mongodb; }; # currently tests mongodb-7_0
}
