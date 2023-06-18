{ lib, datadog-agent }:

datadog-agent.overrideAttrs (attrs: {
  pname = "datadog-trace-agent";

  subPackages = [ "cmd/trace-agent" ];

  tags = [
    "docker"
    "containerd"
    "kubeapiserver"
    "kubelet"
    "otlp"
    "netcgo"
    "podman"
    "secrets"
  ];

  postInstall = null;

  meta = with lib;
    attrs.meta // {
      description = "Trace (APM) agent for the DataDog Agent v7";
      maintainers = with maintainers; [ domenkozar rvl ];
    };
})
