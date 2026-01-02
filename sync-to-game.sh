#!/bin/bash
# Sync dictionary to game_alpha
# Run from dictionary folder: ./sync-to-game.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_DIR="$SCRIPT_DIR/../game_alpha"

echo "Syncing dictionary to game_alpha..."

# Sync source files
echo "  - Copying src/ to game_alpha/src/dictionary/"
cp -r "$SCRIPT_DIR/src/"* "$GAME_DIR/src/dictionary/"

# Sync GLOSSARY.csv
echo "  - Copying GLOSSARY.csv to game_alpha/public/data/CLEAN_FILES/"
cp "$SCRIPT_DIR/data/GLOSSARY.csv" "$GAME_DIR/public/data/CLEAN_FILES/GLOSSARY.csv"

echo "Done! Dictionary synced to game_alpha."
echo ""
echo "Next steps:"
echo "  cd $GAME_DIR"
echo "  npm run build"
