{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, pythonOlder
, deprecated
, hatchling
, importlib-metadata
, setuptools
}:

buildPythonPackage rec {
  pname = "opentelemetry-api";
  version = "1.17.0";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    pname = "opentelemetry_api";
    inherit version;
    hash = "sha256-NID89reDvl1ECiJqUduXnM18SaLpjRx0fJkQMTSNzwQ=";
  };

  nativeBuildInputs = [
    hatchling
    setuptools
  ];

  propagatedBuildInputs = [
    deprecated
    importlib-metadata
  ];

  # nativeCheckInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "Python application configuration via the environment";
    homepage = "https://github.com/DataDog/envier";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}

