{
  "manifest_version": 3,
  "name": "Nexus Mods Mod Manager Auto Clicker",
  "version": "1.1.0",
  "description": "Auto-clicks MOD MANAGER DOWNLOAD buttons on Nexus Mods pages.",
  "permissions": ["activeTab", "scripting", "storage"],
  "host_permissions": ["https://www.nexusmods.com/*"],
  "action": {
    "default_title": "Nexus Mods Auto Clicker",
    "default_popup": "popup.html"
  },
  "background": {
    "service_worker": "background.js"
  },
  "commands": {
    "auto_click_downloads": {
      "suggested_key": {
        "default": "Alt+Shift+D"
      },
      "description": "Start auto-clicking Mod Manager downloads on the current page"
    }
  },
  "content_scripts": [
    {
      "matches": ["https://www.nexusmods.com/*"],
      "js": ["content.js"],
      "run_at": "document_idle"
    }
  ]
}
