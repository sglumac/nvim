if ! command -v stow &> /dev/null; then
  echo "GNU Stow is not installed! Please install it using your package manager (sudo apt install stow # for Debian/Ubuntu)."
else
    stow -t ~ nvim
fi

