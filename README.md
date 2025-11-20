<h1 align="center"><samp> xbanki dotfiles </samp></h1>

# Installation

<details>

<summary>Windows Subsystem for Linux</summary>

> [!NOTE]
> If build-time decryption via `sops-nix` is required, the encryption keys must be present at the configured path **before** the build starts, otherwise it will fail.

## Pre-existing Installation

> [!CAUTION]
> Unless the active login username matches the value specified in `config.toml`, [this guide](#differing-usernames) should be followed instead.

 - In a Nix WSL environment, run the following command:

```bash
sudo nixos-rebuild switch --flake github:xbanki/dots#wsl
```

## Customized Installation

 - Clone the repository, navigate to the root directory and modify the `config.toml` file.
 - If you are already in a Nix environment, and want a completely fresh environment installation, you can follow [this guide](https://nix-community.github.io/NixOS-WSL/building.html) to build a customized WSL tarball.
 - Alternatively, if you just want to update the current system configuration, you can do so by running the following command:

```bash
sudo nixos-rebuild switch --impure --flake ./#wsl
```

 - Congratulations! You are using the dotfiles WSL distribution.

## Differing Usernames

 - Regardless if you're building a local or remote derrivative, the build command should be modified to substitute `switch` for `boot`. Example, when building from remote:

```bash
sudo nixos-rebuild boot --flake github:xbanki/dots#wsl
```

 - Once the system finishes building, exit the session and terminate WSL by running:

```bash
wsl -t NixOS # Or whatever name Nix WSL is installed as.
```

 - After the system has been terminated, run the following command to apply the new generation:

```bash
wsl -d NixOS --user root exit # Again, substitute NixOS if it's installed under a different name.
```

 - Once the command finishes, terminate WSL one more time.
 - Congratulations! You've successfully installed dotfiles WSL distribution, and have changed the login user.

</details>

# License

This repository is licensed under the MIT License. See [LICENSE](./LICENSE) for details.
