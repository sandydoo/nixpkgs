{
  lib,
  stdenv,
  fetchurl,
  perl,
}:

stdenv.mkDerivation rec {
  pname = "bfr";
  version = "1.6";

  src = fetchurl {
    url = "http://www.sourcefiles.org/Utilities/Text_Utilities/bfr-${version}.tar.bz2";
    sha256 = "0fadfssvj9klj4dq9wdrzys1k2a1z2j0p6kgnfgbjv0n1bq6h4cy";
  };

  patches = [
    ./configure-log-compiler-errors-to-stderr.patch
    ./fix-gcc-complaining-about-invalid-configure-example-code.patch

    (fetchurl {
      url = "https://gitweb.gentoo.org/repo/gentoo.git/plain/app-misc/bfr/files/bfr-1.6-perl.patch?id=dec60bb6900d6ebdaaa6aa1dcb845b30b739f9b5";
      sha256 = "1pk9jm3c1qzs727lh0bw61w3qbykaqg4jblywf9pvq5bypk88qfj";
    })
  ];

  buildInputs = [ perl ];

  meta = with lib; {
    description = "General-purpose command-line pipe buffer";
    license = lib.licenses.gpl2Only;
    maintainers = with maintainers; [ pSub ];
    platforms = platforms.linux;
  };
}
