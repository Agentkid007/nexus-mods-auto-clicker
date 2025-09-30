# Nexus Mods + Vortex Auto Click Helpers (Edge + Windows)

What’s included
- Edge extension: Auto-clicks “Mod Manager Download” buttons on Nexus Mods pages.
- AutoHotkey script (Windows): Toggles auto-clicking at the mouse cursor, restricted to the Vortex app window.

Prereqs
- Microsoft Edge (Chromium)
- Windows for Vortex helper: AutoHotkey v1.1+ (https://www.autohotkey.com/)

Install: Edge Extension
1) Open edge://extensions
2) Enable “Developer mode”.
3) Click “Load unpacked” and select the extension folder in this repository.

Usage: Edge Extension
- Open a Nexus Mods mod page (usually the Files tab).
- Click the extension icon and press “Start Auto Click”.
- Hotkey: Alt+Shift+D starts with your saved settings.
- Auto-run on Files pages: Enable/disable in the popup. When enabled, the extension auto-starts on Nexus Mods “Files” pages.
- The extension scrolls to each button, marks it as clicked for the session, and waits the configured delay between clicks.

Tip for Vortex prompts
- The first time a nxm:// link is clicked, Edge may prompt you to open Vortex. Check “Always allow” and confirm to streamline future downloads.

Install: Vortex Auto Clicker (Windows)
1) Install AutoHotkey from https://www.autohotkey.com/.
2) Double-click vortex_autoclicker.ahk to run it.

Usage: Vortex Auto Clicker
- F8: Toggle fast auto-click (10 clicks/sec) at your cursor, only when Vortex is the active window.
- F9: Toggle slow auto-click (3 clicks/sec) at your cursor, only when Vortex is active.
- F10: Stop all auto-clicking.
- Ctrl+` (backtick): Pause/Resume the script.

Notes
- The extension only targets Mod Manager downloads (nxm:// and known text variants).
- Some pages use dropdowns; the extension attempts to open common toggles, then rescans.
- Be mindful of Nexus Mods’ and Vortex’s Terms of Service. Avoid excessive automation.

FAQ
**Q: Do I need to do anything else for this autoclicker to work for Nexus Mods and Vortex?**
A: No, the installation steps above are all you need! Just:
1. For Nexus Mods web pages: Install the Edge extension (steps 1-3 under "Install: Edge Extension")
2. For Vortex app: Install AutoHotkey and run vortex_autoclicker.ahk (steps 1-2 under "Install: Vortex Auto Clicker")
3. Make sure to check "Always allow" when Edge prompts to open Vortex with nxm:// links

That's it! No additional configuration, downloads, or setup required.

Troubleshooting
- If nothing clicks: ensure you’re logged in, on the Files tab, and no overlays block the page.
- When Edge prompts for nxm://, check “Always allow”.
- UI text may vary; update matchers in extension/content.js if necessary.
