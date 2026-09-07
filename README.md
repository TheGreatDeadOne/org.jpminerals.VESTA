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

## Sandbox Permissions

VESTA runs inside a Flatpak sandbox, which by default has no access to the host system. The manifest grants only the permissions the application needs to function:

| Permission | Purpose |
|---|---|
| `--share=ipc` | Shared memory access, required by most X11/GTK toolkits for clipboard, drag-and-drop and image buffers. |
| `--share=network` | Network access. |
| `--socket=x11` / `--socket=wayland` | Access to the display server, so the GUI can be drawn on screen. |
| `--device=dri` | Direct access to the GPU (Direct Rendering Infrastructure), required for hardware-accelerated OpenGL rendering of crystal structures. |
| `--talk-name=org.freedesktop.Notifications` | Allows VESTA to send desktop notifications. |
| `--filesystem=xdg-download` | Read/write access to the user's Downloads folder, so structure files can be opened and saved there. |
| `--filesystem=xdg-documents` | Read/write access to the user's Documents folder, for the same reason. |
| `--env=JAVA_HOME`, `--env=PATH`, `--env=LD_LIBRARY_PATH` | Internal wiring so the bundled JRE, shared libraries and helper binaries (e.g. `STRUCTURE_TIDY`) are located correctly at runtime. |
| `--env=GDK_BACKEND=x11` | Forces the classic X11 backend for GTK, needed because the wxWidgets + Java + GTK3 stack is not fully reliable under native Wayland. |

No broader filesystem access (such as full home directory access) is granted; VESTA can only read/write inside its own sandbox data directory plus the two folders listed above.

## Build and Installation Instructions

Ensure `flatpak` and `flatpak-builder` are installed on your system.

### Direct Build and Install

To compile the dependencies, download missing runtimes from Flathub, create a local repository, and install the application for the current user in a single step, run:

```bash
flatpak-builder --force-clean --user --install-deps-from=flathub --repo=repo --install builddir org.jpminerals.VESTA.yml
```

## Configuration Files

VESTA itself was written to store its settings at the hardcoded path `$HOME/.VESTA`, a convention from its non-sandboxed Linux releases. Inside the Flatpak sandbox, however, `$HOME` does not point to your real home directory — Flatpak redirects it to an app-specific, isolated directory on the host: `~/.var/app/org.jpminerals.VESTA/`.

To respect the XDG Base Directory convention while still satisfying VESTA's hardcoded expectation, the `vesta.sh` launcher does the following on every start:

1. It ensures the proper XDG config directory exists: `$XDG_CONFIG_HOME/VESTA` (inside the sandbox this resolves to `~/.config/VESTA`, which on the host lives at `~/.var/app/org.jpminerals.VESTA/config/VESTA`).
2. It creates `~/.VESTA` as a **symbolic link** pointing to that directory, if it doesn't already exist.

In practice:

* **`~/.config/VESTA`** (host path: `~/.var/app/org.jpminerals.VESTA/config/VESTA`) is where the actual configuration files live.
* **`~/.VESTA`** is *not* a real storage location — it's just a compatibility symlink that redirects VESTA's hardcoded path to the directory above, so the application can keep working unmodified while still storing its data in the correct, XDG-compliant place.

Deleting the symlink is safe (it will be recreated on the next launch); deleting the actual config directory will reset VESTA's settings to defaults.
