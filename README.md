# dotfiles
Backups of my dotfiles for GNU/Linux.

- Using [Chezmoi](https://www.chezmoi.io/) (shey-mwa) to manage the dotfiles.
- Chezmoi adds the files and folders to ~/.local/share/chezmoi

# How-to
- Add a file/directory with **chezmoi add file-folder-name**
- Edit any files in the Chezmoi system with **chezmoi edit directory/file-name**
- Apply edits with **chezmoi apply**
- Go to the Chezmoi default directory with **chezmoi cd**
- To remove a file/directory from Chezmoi (but not delete from .config) use **chezmoi forget directory/file-name**
- To remove from Chezmoi and the system use **chezmoi destroy directory/file-name**
- Add **-v** to see changes before committing them
- Merge changes with **chezmoi merge directory/file-name**

Try to remember to edit the files managed with Chezmoi with the **chezmoi edit** command.

[A helpful reference page](https://www.chezmoi.io/reference/).
