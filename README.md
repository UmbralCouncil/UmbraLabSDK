# Umbra Professional Lab SDK

This SDK assembles reproducible, purpose-built security workstations. It is
not the Umbra Course SDK: there are no lessons, tasks, graders, hints, or
answer keys.

A lab selects capability modules and ordinary NixOS modules. The SDK produces
a headless QEMU/KVM microVM runner plus a machine-readable `lab.json` for
Umbra Studio. Every lab has its own persistent workspace disk, no host shares,
and no network interface unless a future Studio-controlled egress policy
explicitly grants one.

## Start a lab repository

```sh
nix flake init -t github:UmbralCouncil/UmbraLabSDK#professional-lab
```

Capability modules belong to individual lab repositories. The SDK stays
domain-neutral and provides the base microVM module, manifest schemas, lab
builder, template, and public registry.
