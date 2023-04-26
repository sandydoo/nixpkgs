{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, bytecode
, cattrs
, cython
, ddsketch
, envier
, jsonschema
, opentelemetry-api
, setuptools-scm
, tenacity
, toml
, xmltodict
}:

buildPythonPackage rec {
  pname = "ddtrace";
  # version = "0.53.2";
  version = "1.12.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DI4wTQud7PJedgK8znyRW6MpabJkjNCTlN883wqY650=";
    # hash = "sha256-4TNNyEh5bh0mdUpimr80wFH4uLMAl5rwRDbv57inVW0=";
  };

  patches = [
    ./remove-package-urls.patch
  ];

  # Disable the download of the libddwaf library
  postPatch = ''
    substituteInPlace setup.py \
      --replace "build_py\": LibDDWaf_Download" "build_py\": BuildPyCommand"
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    cython
    setuptools-scm
  ];

  propagatedBuildInputs = [ 
    bytecode
    cattrs
    ddsketch
    envier
    jsonschema
    opentelemetry-api
    tenacity
    xmltodict
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  doCheck = false;

  meta = with lib; {
    description = "Datadog Python APM Client";
    homepage = "https://github.com/DataDog/dd-trace-py";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
