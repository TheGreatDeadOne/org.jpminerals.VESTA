# VESTA - Unofficial Flatpak

This repository provides the Flatpak manifest and build instructions for VESTA (Visualization for Electronic and STructural Analysis).

## Licensing and Authorship

This project provides an unofficial Flatpak packaging for VESTA. The VESTA binary downloaded during the build process is owned by its original authors and is governed by their licensing terms. 

VESTA is available free of charge for academic and non-commercial use. For any other use cases, please consult the official VESTA website. This manifest automates the download of the pre-compiled binary and its encapsulation within a Flatpak sandbox.

## Runtimes and Dependencies

The build process requires the following base technologies.

### Base Runtimes
* **Runtime:** org.gnome.Platform (Version 50)
* **SDK:** org.gnome.Sdk (Version 50)

### Extensions
* **OpenJDK 17:** org.freedesktop.Sdk.Extension.openjdk17 (Provides the Java Runtime Environment)

### Bundled Modules
The following components are compiled and bundled locally within the Flatpak environment:
* **OpenJDK:** Local JRE copy pointing to the extension.
* **GLU:** OpenGL utility library required for visual processing.
* **wxWidgets:** GUI framework configured with GTK3 and OpenGL support.

## Build and Installation Instructions

Ensure `flatpak` and `flatpak-builder` are installed on your system.

### Direct Build and Install

To compile the dependencies, download missing runtimes from Flathub, create a local repository, and install the application for the current user in a single step, run:

```bash
flatpak-builder --force-clean --user --install-deps-from=flathub --repo=repo --install builddir org.jpminerals.VESTA.yml
