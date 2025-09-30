async function getActiveTabId() {
  const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
  return tab?.id;
}

async function loadSettings() {
  const saved = await chrome.storage.sync.get({
    delayMs: 1500,
    autoRunFiles: true
  });
  document.getElementById("delayMs").value = saved.delayMs;
  document.getElementById("autoRunFiles").checked = !!saved.autoRunFiles;
}

async function saveSettings() {
  const delayMs = Number(document.getElementById("delayMs").value || 1500);
  const autoRunFiles = document.getElementById("autoRunFiles").checked;
  await chrome.storage.sync.set({ delayMs, autoRunFiles });
}

document.addEventListener("DOMContentLoaded", async () => {
  await loadSettings();

  document.getElementById("start").addEventListener("click", async () => {
    await saveSettings();
    const tabId = await getActiveTabId();
    if (!tabId) return;

    const settings = await chrome.storage.sync.get({ delayMs: 1500 });
    chrome.tabs.sendMessage(tabId, { type: "START_AUTO_CLICK", settings });

    const status = document.getElementById("status");
    status.textContent = "Started… (Alt+Shift+D works too)";
    setTimeout(() => (status.textContent = ""), 3000);
  });

  document.getElementById("autoRunFiles").addEventListener("change", saveSettings);
  document.getElementById("delayMs").addEventListener("change", saveSettings);
});
