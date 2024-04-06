## You can find all files in /final

## downloading disko.nix
```bash
curl https://raw.githubusercontent.com/UltraToon/Nixfiles/main/disko.nix -O /tmp/disko.nix
```

## disko formatting command
uses NVME
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/nvme0n1"'
```

## initialize flake
```bash
nix flake init --template github:vimjoyer/impermanent-setup
```

## installing nixos
```bash
nixos-install --root /mnt --flake /mnt/etc/nixos#default
```
