{ ... }:

{
  # The installed Firefox is the standalone /opt Firefox. Its active profile is
  # selected by profiles.ini and currently lives at yd52ekn3.default-release.
  # Keep the enabled Fastfox subset in Home Manager as the source of truth.
  home.file.".config/mozilla/firefox/yd52ekn3.default-release/user.js".text = ''
    // Betterfox Fastfox 154.0, pinned from commit 067172a4b0dc90e78e5b8b94d9abfe6430c6a7be.
    // Fastfox only: no Securefox, Peskyfox, Smoothfox, or commented experimental prefs.
    // Firefox reads user.js at startup and re-applies these values on each launch.
    user_pref("gfx.content.skia-font-cache-size", 20);
    user_pref("content.notify.interval", 100000);
    user_pref("gfx.canvas.accelerated.cache-size", 512);
    user_pref("media.cache_readahead_limit", 3600);
    user_pref("media.cache_resume_threshold", 1800);
    user_pref("image.mem.decode_bytes_at_a_time", 32768);
    user_pref("network.buffer.cache.size", 65535);
    user_pref("network.buffer.cache.count", 48);
    user_pref("network.http.max-connections", 1800);
    user_pref("network.http.max-persistent-connections-per-server", 10);
    user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
    user_pref("network.http.request.max-start-delay", 5);
    user_pref("network.dnsCacheExpiration", 3600);
  '';
}
