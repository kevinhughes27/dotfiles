#!/bin/bash

if pgrep ttyd > /dev/null; then
  color_magenta='#c678dd'
  color_bg='#31353F'
  rsep=""

  pair_style="#[bg=$color_magenta fg=$color_bg bold]"
  pair_style_end="#[bg=$color_bg fg=$color_magenta]"
  pair_status="$pair_style_end$rsep$pair_style PAIRING $rsep$pair_style_end"

  echo $pair_status
fi
