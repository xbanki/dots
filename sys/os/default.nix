{
  inputs,
  ...
}:

let
  system = "x86_64-linux";

in
with inputs;
nixpkgs.lib.nixosSystem {
  inherit system;
}
