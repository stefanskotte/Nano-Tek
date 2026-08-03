# Nano-Tek

A tiny, modern reimagining of the classic **Gotek** floppy-disk-drive emulator. Nano-Tek keeps the full feature set of a Gotek-style FDD emulator but packs it onto a board that is a fraction of the size — hence *Nano*-Tek.

<p align="center">
  <img src="docs/images/nano-tek-3d.png" alt="Nano-Tek PCB — 3D render" width="720">
</p>

The schematic is derived from the open-source [**OpenFlops**](https://github.com/SukkoPera/OpenFlops) design by *SukkoPera*, re-laid-out on a compact 4-layer PCB.

## Highlights

- **A lot smaller.** The board measures just **55 × 42 mm** — roughly half the footprint of a standard Gotek, while keeping the same 34-pin floppy interface.
- **FlashFloppy-compatible.** Built around the **STM32F105RBT6** (Cortex-M3) MCU, so it runs the popular [FlashFloppy](https://github.com/keirf/flashfloppy) firmware.
- **USB-C.** A modern USB-C connector replaces the old micro-USB / bulky headers.
- **OLED + rotary encoder** headers for a clean front-panel UI.
- **Speaker output** for the drive-activity "click".
- **4-layer PCB** for clean power and signal routing in a small area.

## Hardware overview

| Function          | Part / Connector                     | Ref     |
|-------------------|--------------------------------------|---------|
| Microcontroller   | STM32F105RBT6 (LQFP-64)              | U1      |
| Bus buffer        | 74LCX07 (TSSOP-14)                   | U2      |
| 3.3 V regulator   | AP2112K-3.3 (SOT-23-5)               | U3      |
| Clock             | 8 MHz crystal                        | X1      |
| Floppy interface  | 34-pin IDC header                    | CN3     |
| Power input       | 4-pin power connector (171826-4)     | CN1     |
| USB               | USB-C (SMD)                          | —       |
| Display           | OLED header (I²C / SPI)              | J3      |
| Input             | Rotary encoder header                | J4      |
| Audio             | Speaker header                       | J1      |

See [`Nano-Tek_Schematics.pdf`](Nano-Tek_Schematics.pdf) for the full schematic and [`jlcpcb/production_files/BOM-Nano-Tek.csv`](jlcpcb/production_files/BOM-Nano-Tek.csv) for the complete bill of materials.

## Repository layout

```
Nano-Tek.kicad_pro      KiCad 10 project
Nano-Tek.kicad_sch      Schematic
Nano-Tek.kicad_pcb      PCB layout (4-layer)
Nano-Tek.pretty/        Project-specific footprint library
3dmodels/               3D models for connectors/parts
docs/images/            Rendered board images
jlcpcb/                 Gerbers, BOM and CPL for JLCPCB assembly
Nano-Tek_Schematics.pdf Schematic export
Nano-Tek_PCB.pdf        Fabrication drawing export
```

## Manufacturing

Ready-to-order production files for **JLCPCB** (4-layer) are provided in
[`jlcpcb/production_files/`](jlcpcb/production_files/):

- `GERBER-Nano-Tek.zip` — Gerber + drill files
- `BOM-Nano-Tek.csv` — bill of materials (with LCSC part numbers)
- `CPL-Nano-Tek.csv` — component placement / pick-and-place

## Firmware

Flash the board with [FlashFloppy](https://github.com/keirf/flashfloppy) via the SWD/boot header (`SWCLK`/`SWDIO`) or DFU over USB. Refer to the FlashFloppy documentation for build and update instructions.

## Credits & license

- Schematic derived from [OpenFlops](https://github.com/SukkoPera/OpenFlops) by **SukkoPera**.
- Firmware: [FlashFloppy](https://github.com/keirf/flashfloppy) by **Keir Fraser**.

Please check the upstream OpenFlops project for its licensing terms; this derivative is shared in the same open-hardware spirit.

---

*Nano-Tek — the Gotek, shrunk.* Rev 1.0.
