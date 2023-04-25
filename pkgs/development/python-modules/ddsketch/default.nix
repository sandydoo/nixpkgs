{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, pythonOlder
, numpy
, protobuf
, setuptools-scm
, six
, typing
}:

buildPythonPackage rec {
  pname = "ddsketch";
  version = "2.0.4";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-MvcxQHf+yHR9T6667CyFS1/8OZxfVS9z+pQCT0jXTWQ=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [ protobuf six ]
    ++ lib.optionals (pythonOlder "3.5") [ typing ];

  nativeCheckInputs = [ numpy pytestCheckHook ];

  meta = with lib; {
    description = "Python implementations of the distributed quantile sketch algorithm DDSketch";
    homepage = "https://github.com/DataDog/sketches-py";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
