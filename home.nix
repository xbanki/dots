#   Home Manager configuration
#
# Automatically applies user settings defined in `local.config.toml`, which
# overrides `config.toml`. Installed packages depend on the target system
# configuration.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  useUserPackages = true;
  useGlobalPkgs = true;
}
