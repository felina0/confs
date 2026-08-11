#!/bin/bash
ROOT="$(get-backup-root.sh)/$(date '+%Y-%m')"
PREV="$(get-backup-root.sh)/$(date -d "$(date '+%Y-%m') - 15 last month" '+%Y-%m')"

mkdir -p "$ROOT/game-backups"

# delete extraneous files from destination
RSYNC_OPTS="--archive --human-readable --delete-after --recursive --ignore-missing-args"

_backup_game() {
  SRC="$1"
  DEST="$2"
  NAME="$3"
  PUBLISHED_YEAR="$4"
  if [ -d "$SRC" ] && ! diff -qr "$SRC" "$PREV/$DEST" ; then
    echo "Game backup: $NAME ($PUBLISHED_YEAR) from $SRC"
    rsync $RSYNC_OPTS "$SRC/" "$ROOT/$DEST"
  fi
}

_backup_game \
  "$HOME/.steam/steam/steamapps/compatdata/3146520/pfx/drive_c/users/steamuser/AppData/Roaming"  \
  "game-backups/webfishing" \
  "WEBFISHING" "2024"

_backup_game \
  "$HOME/.steam/steam/steamapps/compatdata/335300/pfx/drive_c/users/steamuser/AppData/Roaming" \
  "game-backups/DS2_dark_souls_ii_DarkSoulsII" \
  "DARK SOULS II" "2011"

_backup_game \
  "$HOME/.steam/steam/steamapps/common/Call of Duty\ 2/main/players" \
  "game-backups/call_of_duty_2_2005" \
  "CALL OF DUTY 2" "2005"

_backup_game \
  "$HOME/.steam/steam/steamapps/compatdata/1177980/pfx/drive_c/users/steamuser/AppData/LocalLow" \
  "game-backups/little_kitten_big_city" \
  "LKBC" "2024"

_backup_game \
  "$HOME/Games/Heroic/VtMB/Unofficial_Patch/save/" \
  "game-backups/vtmb_2004" \
  "Vampire the Masquerade Bloodlines" "2004"
