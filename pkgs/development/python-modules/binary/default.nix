{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "binary";
  version = "1.0.0";
  format = "setuptools";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bsAQ5Y9zMevIvJY42+bGbWNd5g1YGLByO+9N6tDsKKY=";
  };

  nativeBuildInputs = [
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  doCheck = false;

  meta = with lib; {
    description = "Easily convert between binary and SI units (kibibyte, kilobyte, etc.).";
    homepage = "https://github.com/ofek/binary";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
