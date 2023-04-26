{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, pythonOlder
, setuptools-scm
, sphinx
, typing
}:

buildPythonPackage rec {
  pname = "envier";
  version = "0.4.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-5o3NHtZ9i2MTiD4n3/PnAbf7qUTS7Ut/U9DMLhI2SoI=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  propagatedBuildInputs = [] 
    ++ lib.optionals (pythonOlder "3.5") [ typing ];

  nativeCheckInputs = [ sphinx pytestCheckHook ];

  doCheck = false;

  meta = with lib; {
    description = "Python application configuration via the environment";
    homepage = "https://github.com/DataDog/envier";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}

