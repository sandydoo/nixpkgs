{
  lib ? pkgs.lib,
  pkgs,
}:

# The aws-sdk-cpp tests are flaky.  Since pull requests to staging
# cause nix to be rebuilt, this means that staging PRs end up
# getting false CI failures due to whatever is flaky in the AWS
# SDK tests.  Since none of our CI needs to (or should be able to)
# contact AWS S3, let's just omit it all from the Nix that runs
# CI.  Bonus: the tests build way faster.
#
# See also: https://github.com/NixOS/nix/issues/7582

builtins.mapAttrs (
  attr: pkg:
  if lib.versionAtLeast pkg.version "2.29pre" then
    pkg.overrideScope (finalScope: prevScope: { aws-sdk-cpp = null; })
  else
    pkg.override { withAWS = false; }
) pkgs.nixVersions
