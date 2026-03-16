if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

if [ -d "$HOME/.config/secrets" ]; then
    for f in "$HOME"/.config/secrets/*.env; do
        [ -f "$f" ] || continue
        . "$f"
    done
fi

if [ -d "$HOME/.personal/profile" ]; then
    for f in "$HOME"/.personal/profile/*; do . "$f"; done
fi
if [ -f "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi
