# Dotfiles

Personal dotfiles managed with [Chezmoi](https://www.chezmoi.io/) for a terminal-centric development environment.

## Features

- **Neovim**: LazyVim distribution with extensive plugin ecosystem
- **Tmux**: Modular configuration with custom keybindings and theming
- **Git**: Conditional configuration for work/personal separation
- **QMK**: Custom keyboard firmware for silakka54 keyboard
- **AI Tools**: Configured for Aider, Supermaven, and Avante

## Prerequisites

- [Chezmoi](https://www.chezmoi.io/install/)
- [Neovim](https://neovim.io/) (>= 0.9.0)
- [Tmux](https://github.com/tmux/tmux)
- [Git](https://git-scm.com/)
- [QMK CLI](https://docs.qmk.fm/#/newbs_getting_started) (optional, for keyboard firmware)

## Installation

1. **Install Chezmoi**:

   ```bash
   # On macOS
   brew install chezmoi

   # On Linux
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. **Clone and setup dotfiles**:

   ```bash
   # Clone the repository
   git clone https://github.com/nisibz/dotfiles.git ~/dotfiles

   # Create Chezmoi config directory
   mkdir -p ~/.config/chezmoi

   # Configure Chezmoi to use local source
   cat > ~/.config/chezmoi/chezmoi.toml << EOF
   [sourceDir]
       path = "~/dotfiles/chezmoi"
   EOF

   # Initialize Chezmoi with local source
   chezmoi init --source ~/dotfiles/chezmoi
   ```

3. **Preview changes**:

   ```bash
   chezmoi diff
   ```

4. **Apply dotfiles**:

   ```bash
   chezmoi apply
   ```

## Usage

### Managing Dotfiles

```bash
# Add a new file to be managed
chezmoi add ~/.newconfig

# Edit a managed file
chezmoi edit ~/.gitconfig

# Apply changes
chezmoi apply

# Check status
chezmoi status

# Pull and apply updates
chezmoi update
```

### Neovim Setup

The Neovim configuration uses LazyVim with:

- **Language Support**: Go, Python, TypeScript, Vue, Docker, Terraform, SQL
- **AI Integration**: Supermaven for code completion
- **Database Tools**: vim-dadbod suite for database interaction
- **REST Client**: kulala.nvim for API development

Plugins are automatically installed on first startup. Configuration is located in `~/.config/nvim/`.

### Tmux Configuration

Modular tmux setup with separate files for:

- **Options**: Core settings and terminal configuration
- **Keybindings**: Custom key mappings
- **Theme**: Visual customization
- **Plugins**: Plugin management

Configuration is located in `~/.config/tmux/`.

### Git Configuration

Conditional configuration that automatically switches between personal and work settings:

- **Personal**: Default configuration
- **Work**: Activated for repositories in `~/Documents/works/`

Work-specific configuration should be placed in `~/.config/gitconfig/work`.

### QMK Keyboard (Optional)

Custom firmware for silakka54 keyboard with:

- Home row modifiers
- Multiple layers (base, gaming, navigation, symbols, function, mouse)
- Layer-specific RGB lighting

```bash
# Compile firmware
qmk compile -kb silakka54 -km default

# Flash to keyboard
qmk flash -kb silakka54 -km default
```

## Customization

### Adding New Configurations

1. **Add file to Chezmoi**:

   ```bash
   chezmoi add ~/.newconfig
   ```

2. **Edit through Chezmoi**:

   ```bash
   chezmoi edit ~/.newconfig
   ```

3. **Apply changes**:

   ```bash
   chezmoi apply
   ```

### Neovim Plugins

- Plugins are managed through LazyVim
- Add new plugins by editing `~/.config/nvim/lua/plugins/`
- Lock versions by committing changes to `lazy-lock.json`

### Work Git Configuration

Create work-specific git configuration:

```bash
# Create work config
mkdir -p ~/.config/gitconfig
chezmoi edit ~/.config/gitconfig/work
```

Add your work-specific settings:

```ini
[user]
    name = "Your Work Name"
    email = "you@company.com"
```

## Troubleshooting

### Chezmoi Issues

```bash
# Check what Chezmoi would do
chezmoi diff

# Verify Chezmoi state
chezmoi doctor

# Reset if needed
chezmoi init --force
```

### Neovim Issues

```bash
# Check health
nvim --headless -c 'checkhealth' -c 'qa'

# Reinstall plugins
rm -rf ~/.local/share/nvim
# Restart Neovim to reinstall
```

## License

MIT License - feel free to use and modify as needed.

