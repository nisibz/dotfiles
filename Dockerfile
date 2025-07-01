# Multi-stage build for optimized Arch Linux development environment
FROM archlinux:latest AS base

# Set non-interactive mode and configure pacman with multiple reliable mirrors
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
  echo 'Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist && \
  echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist && \
  echo 'Server = https://mirror.leaseweb.net/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist && \
  echo 'Server = https://ftp.halifax.rwth-aachen.de/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist

# Initialize pacman keyring and update system
RUN pacman-key --init && \
  pacman-key --populate archlinux

# Update system with retry logic
RUN for i in {1..3}; do pacman -Syu --noconfirm && break || sleep 5; done

# Install essential packages
RUN pacman -S --noconfirm --needed \
  base \
  base-devel \
  git \
  sudo \
  wget \
  curl && \
  pacman -Scc --noconfirm

# Install development tools
RUN pacman -S --noconfirm --needed \
  vim \
  neovim \
  zsh \
  chezmoi && \
  pacman -Scc --noconfirm

# Configure sudo for wheel group
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Create main user
RUN useradd -m -G wheel -s /bin/bash archuser

# Build stage for yay AUR helper
FROM base AS yay-builder

# Create temporary builder user
RUN useradd -m -G wheel -s /bin/bash builder

USER builder
WORKDIR /tmp

# Install yay with optimized build flags
RUN git clone --depth=1 https://aur.archlinux.org/yay.git && \
  cd yay && \
  makepkg -si --noconfirm --skippgpcheck

# Final stage - copy only what we need
FROM base AS final

# Copy yay binary from builder stage
COPY --from=yay-builder /usr/bin/yay /usr/bin/yay

# Set up user environment
USER archuser
WORKDIR /home/archuser

# Create common directories
RUN mkdir -p ~/.config ~/.cache ~/.local/share

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD pacman -Q yay > /dev/null || exit 1

# Default command
CMD ["/bin/bash"]

# Labels for metadata
LABEL maintainer="archuser" \
  description="Optimized Arch Linux development environment with yay AUR helper" \
  version="1.0" \
  arch="x86_64"
