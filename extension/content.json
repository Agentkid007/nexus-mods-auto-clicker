(function () {
  let running = false;
  let autoRunTriggered = false;

  // Match common variants of the Mod Manager button text
  const reList = [
    /mod manager download/i,
    /download with manager/i,
    /download with mod manager/i
  ];

  function isFilesPage() {
    try {
      const url = new URL(location.href);
      const onMods = /\/mods\//.test(url.pathname);
      const onCollections = /\/collections\//.test(url.pathname);
      const hasFilesTab = url.searchParams.get("tab") === "files";
      const pathFiles = /\/files(\/|$)/.test(url.pathname);
      return (url.hostname.endsWith("nexusmods.com")) && (onMods || onCollections) && (hasFilesTab || pathFiles);
    } catch (_) {
      return false;
    }
  }

  function getCandidateButtons() {
    // Prefer nxm:// links (manager download)
    const nxmLinks = Array.from(document.querySelectorAll('a[href^="nxm://"]'));
    // Fallback to text matches on anchors/buttons
    const clickable = Array.from(document.querySelectorAll('a, button'));
    const textMatches = clickable.filter((el) => {
      const text = (el.innerText || el.textContent || "").trim();
      return reList.some((re) => re.test(text));
    });
    // Merge and de-dup
    const set = new Set();
    const merged = [];
    for (const el of [...nxmLinks, ...textMatches]) {
      if (!el || !el.isConnected) continue;
      if (set.has(el)) continue;
      set.add(el);
      merged.push(el);
    }
    return merged;
  }

  function uniqVisibleButtons(els) {
    const seen = new Set();
    return els.filter((el) => {
      if (!el.isConnected) return false;
      if (el.offsetParent === null) return false; // not visible
      if (el.dataset.nxaClicked === "1") return false;
      const key = (el.getAttribute("href") || "") + "::" + (el.innerText || el.textContent || "");
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
    });
  }

  async function clickSequentially(buttons, delayMs) {
    for (const btn of buttons) {
      if (!running) break;
      try {
        btn.scrollIntoView({ behavior: "smooth", block: "center" });
        await new Promise((r) => setTimeout(r, Math.min(400, delayMs)));
        btn.dataset.nxaClicked = "1";
        btn.click();
      } catch (_) {}
      await new Promise((r) => setTimeout(r, delayMs));
    }
  }

  // Try to expand common dropdowns before scanning again
  function pokeToggles() {
    const toggles = document.querySelectorAll('[data-toggle], .dropdown-toggle, .toggle, .more-actions, [aria-haspopup="true"]');
    for (const t of toggles) {
      try { t.click(); } catch (_) {}
    }
  }

  async function startAutoClick(settings) {
    if (running) return;
    running = true;

    // First scan
    let buttons = uniqVisibleButtons(getCandidateButtons());

    // Try opening dropdowns/menus, then rescan
    pokeToggles();
    await new Promise((r) => setTimeout(r, 250));
    let buttons2 = uniqVisibleButtons(getCandidateButtons());

    // Combine, preserve order
    const final = uniqVisibleButtons([...buttons, ...buttons2]);

    await clickSequentially(final, Math.max(300, Number(settings.delayMs) || 1500));
    running = false;
  }

  function scheduleAutoRun() {
    chrome.storage.sync.get({ delayMs: 1500, autoRunFiles: true }).then((settings) => {
      if (!autoRunTriggered && settings.autoRunFiles && isFilesPage()) {
        autoRunTriggered = true;
        startAutoClick(settings);
      }
    });
  }

  // Listen for manual start from popup/command
  chrome.runtime.onMessage.addListener((msg) => {
    if (msg?.type === "START_AUTO_CLICK") {
      startAutoClick(msg.settings);
    }
  });

  // Optional in-page hotkey fallback: Shift+D
  document.addEventListener("keydown", (e) => {
    if (e.shiftKey && e.code === "KeyD") {
      chrome.storage.sync.get({ delayMs: 1500 }).then((settings) => startAutoClick(settings));
    }
  });

  // Detect SPA-like navigations and run on Files pages
  (function patchHistory() {
    const _ps = history.pushState;
    const _rs = history.replaceState;
    history.pushState = function () { _ps.apply(this, arguments); window.dispatchEvent(new Event('locationchange')); };
    history.replaceState = function () { _rs.apply(this, arguments); window.dispatchEvent(new Event('locationchange')); };
  })();

  window.addEventListener('popstate', () => window.dispatchEvent(new Event('locationchange')));
  window.addEventListener('locationchange', () => { autoRunTriggered = false; scheduleAutoRun(); });

  // Initial attempt after content loads
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scheduleAutoRun);
  } else {
    scheduleAutoRun();
  }
})();
