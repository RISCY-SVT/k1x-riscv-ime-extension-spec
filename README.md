# RISC-V IME set Specification

## Introduction
This is a matrix extension proposal under the RISC-V IME extension standard. It has the following features.

* Low cost
    - Reuse the vector registers and the related CSRs.

* Compatibility
    - Support VLEN of vector registers from 128 bit to 4096 bit
    - Almost binary portability

* Rich data types
    - Integer int4/int8/int16
    - Floating point fp4/fp8/fp16/bf16

## Build
This project is built from AsciiDoc sources. The most reliable way to build every output format (`pdf`, `html`, `md`) is to use the upstream [RISC-V Docs Base Container Image repository](https://github.com/riscv/riscv-docs-base-container-image), because it already contains the required Ruby gems, `pandoc`, and `wavedrom-cli`.

### Docker build

```bash
git clone https://github.com/spacemit-com/riscv-ime-extension-spec.git
cd riscv-ime-extension-spec

docker pull ghcr.io/riscv/riscv-docs-base-container-image:latest
docker run --rm -it -e LANG=C.utf8 -v "$(pwd)":/build \
  ghcr.io/riscv/riscv-docs-base-container-image:latest /bin/bash

# inside the container
cd /build/build
make
```

Available targets in `build/Makefile`:

* `make` - build all default artifacts (`.pdf`, `.html`, `.md`)
* `make ime-pdf` - build PDF only
* `make ime-html` - build HTML only
* `make ime-md` - build Markdown only

The generated files are written to the `build/` directory:

* `spacemit-ime-asciidoc.pdf`
* `spacemit-ime-asciidoc.html`
* `spacemit-ime-asciidoc.md`
* generated WaveDrom SVG assets in `build/images/`

### Native build dependencies

Local native builds were verified on a RHEL/Fedora-like system. To build all three formats locally you need:

* Ruby and RubyGems
* `gcc`, `g++`, `make`, `cmake`, `bison`, and `flex`
* `pandoc` for Markdown generation
* Node.js + `npm` for `wavedrom-cli`
* the development libraries required by `asciidoctor-diagram` and `asciidoctor-mathematical`
* the Ruby gems `asciidoctor`, `asciidoctor-bibtex`, `asciidoctor-diagram`, `asciidoctor-pdf`, `mathematical`, and `asciidoctor-mathematical`

`wavedrom-cli` is most reliable on a current Node.js LTS release such as Node 20 or 22. If several Node versions are installed, make sure `npm` resolves to the LTS toolchain while installing `wavedrom-cli`.

Example installation on RHEL/Fedora-like systems:

```bash
sudo dnf install -y \
  ruby ruby-devel gcc gcc-c++ make cmake bison flex \
  pandoc nodejs npm \
  cairo-devel cairo-gobject-devel pango-devel gdk-pixbuf2-devel \
  giflib-devel librsvg2-devel libjpeg-turbo-devel pixman-devel \
  libtiff-devel liblerc-devel jbigkit-devel \
  libffi-devel sqlite-devel libxml2-devel glib2-devel \
  pkgconf-pkg-config

gem install --user-install --no-document \
  asciidoctor asciidoctor-bibtex asciidoctor-diagram \
  asciidoctor-pdf mathematical asciidoctor-mathematical

env PATH=/usr/bin:/usr/sbin:$PATH npm install -g --prefix "$HOME/.local" wavedrom-cli@2.6.8
```

If the Ruby gem executables are not on your `PATH`, add the RubyGems user executable directory before invoking `make`.

Then build from the repository root:

```bash
cd build
make clean
make ime-pdf ime-html ime-md
```

## Official Version
- **Official versions** of the specifications are available at the [github release page](https://github.com/spacemit-com/riscv-ime-extension-spec/releases)


## Contributing
If you would like to contribute to this documentation, please refer to the [Documentation Developer's Guide](https://github.com/riscv/docs-dev-guide).

## Acknowledgement
This project refers to [riscv-isa-manual](https://github.com/riscv/riscv-isa-manual) and [riscv-matrix-extension-spec](https://github.com/T-head-Semi/riscv-matrix-extension-spec?tab=readme-ov-file). Thanks a lot.
