## My configuration or "dot" files

Managing them with a bash script that symlinks everything where it needs to go.

## Naming Conventions for ~/ Folder

This document outlines the naming conventions used in my home directory for consistency and ease of use.

### 1. Top-Level Directories

- GUI-friendly directories (created by default in Debian/GNOME/KDE) keep **Capitalized** names:
  - `Desktop` (optional - for desktop shortcuts)
  - `Documents`
  - `Downloads`
  - `Music` (optional - for music player files)
  - `Pictures`
  - `Videos`
- Personal directories I create for work or development are **lowercase**:
  - `projects`
    - art
    - music
    - photos
  - `github`

### 2. Sub-Directories: Folders Inside Folders

- Use **lowercase letters**.
- Separate words with **hyphens (-)**.
- Examples:
  - `cat-and-bot`
  - `my-assets`
  - `another-project`

### 3. Files

- Use **lowercase letters**.
- Separate words with **underscores (\_)**.
- Include extensions as appropriate (`.txt`, `.json`, `.md`, `.png`, etc.).
- Examples:
  - `notes_2025.txt`
  - `config_file.json`
  - `readme_file.md`

### 4. Hidden Files / Dotfiles

- Configuration files or folders are prefixed with a dot (`.`):
  - `.bashrc`
  - `.config/`
  - `.gitconfig`

### 5. Summary

| Type                 | Naming Style           | Separator  | Example             |
| -------------------- | ---------------------- | ---------- | ------------------- |
| Top-level GUI folder | Capitalized            | N/A        | `Documents`         |
| Personal folder      | Lowercase              | Hyphen     | `cat-and-bot`       |
| File                 | Lowercase              | Underscore | `project_notes.txt` |
| Hidden config        | Lowercase + dot prefix | Underscore | `.config_file`      |
