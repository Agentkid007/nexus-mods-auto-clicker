chrome.commands.onCommand.addListener(async (command) => {
  if (command !== "auto_click_downloads") return;
  try {
    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
    if (!tab?.id) return;

    const settings = await chrome.storage.sync.get({
      delayMs: 1500
    });

    chrome.tabs.sendMessage(tab.id, { type: "START_AUTO_CLICK", settings });
  } catch (e) {
    // no-op
  }
});
