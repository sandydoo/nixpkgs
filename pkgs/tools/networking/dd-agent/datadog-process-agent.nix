{ lib, datadog-agent }:

datadog-agent.overrideAttrs (attrs: {
  pname = "datadog-process-agent";

  subPackages = [ "cmd/process-agent" ];

  tags = lib.flip lib.pipe
    [ (lib.subtractLists ["otlp" "python" "trivy"])
      lib.unique
    ]
    (attrs.tags ++ [
      "clusterchecks"
      "fargateprocess"
      "orchestrator"
    ]);

  postInstall = null;

  meta = with lib;
    attrs.meta // {
      description = "Live process collector for the DataDog Agent v7";
      maintainers = with maintainers; [ domenkozar rvl ];
    };
})
