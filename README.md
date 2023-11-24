# Shay's modification to integrate a standalone RippleDetectorUI
Ripple detector upgraded from old Trodes dev. This is now a standalone module that should interface both with Trodes and Neuropixels PXIe --> Open Ephys data. 

UPGRADES! NPX --> my module as well as loading the NPX data from the probe to the buffer that's sent to OE is now vectorized. This is done with AVX instructions similar to the Trodes handling of Neuropixels data. Objectively this will cause a speedup and minimize closed-loop latency. How much though? I'm unsure I'll quantify it soon enough.

RippleDetectorUI binaries are included in the module. Docs and usage will be provided later but this is expected to only work on Windows with Neuropixels. Intan interface on Linux with Trodes should work as well once this is finalized fully. I do want to maintain Spikegadgets/Trodes support for the Neuropixels headstage as well eventually but alas I don't hav ethe hardware.

# Neuropixels PXI Plugin

![Hardware diagram](https://open-ephys.github.io/gui-docs/_images/neuropix-pxi-01.png)

This plugin makes it possible to stream Neuropixels data from a PXI-based acquisition system into the [Open Ephys GUI](https://github.com/open-ephys/plugin-gui).

## Installation

This plugin is not included by default, but must be added via the GUI's Plugin Installer. To access the Plugin Installer, press **ctrl-P** from inside the GUI. Once the installer is loaded, browse to the "Neuropix-PXI" plugin, and click "Install."

If you're upgrading from a previous version, you will need to close and re-open the GUI before you can use the plugin in a signal chain.

## Usage

Instructions for using the Neuropixels PXI plugin are available [here](https://open-ephys.github.io/gui-docs/User-Manual/Plugins/Neuropixels-PXI.html).

## Hardware requirements

- PXI chassis and remote control module

- PCIe interface card housed in the computer

- Cables to connect the remote control module to the PCIe card

- One or more Neuropixels PXIe modules (available from IMEC)

- Neuropixels cables, headstages, and probes (available from IMEC)

## Compatible probes

- Neuropixels 1.0

- Neuropixels 2.0 (single shank and multishank)

- Neuropixels Ultra (fixed and switchable)

- Neuropixels NHP (active and passive)

- Neuropixels Opto

## Compatible PXI basestation firmware

### Plugin version: 0.4.x

API version: 3.42
- QBSC firmware: B176 (appears as 3.2176)
- BS firmware: B137 (appears as 2.0137)

### Plugin version: 0.5.x

API version: 3.57
- QBSC firmware: B176 (appears as 3.2176)
- BS firmware: B169 (appears as 2.0169)

### Plugin version: 0.6.x

API version: 3.62
- QBSC firmware: B189 (appears as 3.2189)
- BS firmware: B169 (appears as 2.0169)

## License

This source code is made available under a [GPL 3.0 License](LICENSE).

## Credits

This plugin was created by Josh Siegle, Pavel Kulik, and Anjal Doshi at the Allen Institute.

We thank Bill Karsh (Janelia) and Jan Putzeys (imec) for helpful advice throughout the development process.

© 2023 Allen Institute and Open Ephys
