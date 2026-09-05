# Umbra Professional Lab SDK

This SDK assembles reproducible, purpose-built security workstations. It is
not the Umbra Course SDK: there are no lessons, tasks, graders, hints, or
answer keys.

A lab selects capability modules and ordinary NixOS modules. The SDK produces
a headless QEMU/KVM microVM runner plus a machine-readable `lab.json` for
Umbra Studio. Every lab has its own persistent workspace disk, no host shares,
and no network interface unless a future Studio-controlled egress policy
explicitly grants one.

## Build the OSINT workbench

```sh
nix build .#osint-workbench
./result/bin/microvm-run
```

## Start a lab repository

```sh
nix flake init -t github:UmbralCouncil/UmbraLabSDK#professional-lab
```

The initial capability catalog includes identity research, domain
intelligence, metadata analysis, web collection, geospatial analysis, and a
persistent case-management workspace.
