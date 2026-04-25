<div align="center">

# LeanBrave
<img width="200" height="300" alt="Image" src="https://github.com/user-attachments/assets/efb87da3-ca24-413f-b30c-605268828f10" />

---

## Brave Browser Debloater

LeanBrave is a PowerShell script that declutters the Brave Browser. It allows you to quickly toggle features on or off, optimizing your settings 
for better privacy and a cleaner experience.

</div>

---

## 📂 Configuration Presets

Choose a configuration that matches your needs:

<details>
<summary> 🌑 <b>Maximum Privacy</b> </summary>

- **Telemetry:** Purges all metrics, safe browsing reports, and URL data collection.
- **Privacy:** Disables Autofill, Password Manager, and Browser Sign-in; blocks 3rd-party cookies and WebRTC IP leaks.
- **Brave Bloat:** Kills Rewards, Wallet, VPN, Leo AI, and Sync.
- **DNS:** Use **Custom** mode with a provider like NextDNS or Mullvad.
- **Best for:** Users who want zero data leakage.
</details>

<details>
<summary> ⚡ <b>Performance</b> </summary>

- **Performance:** Kills background mode, shopping trackers, and media recommendations.
- **Resources:** Disables Spellcheck, Search Suggestions, and Promotions.
- **Cleanup:** Forces PDFs to open externally and disables "Default Browser" nagging.
- **Best for:** Low-spec systems or users who want a lightning-fast UI.
</details>

<details>
<summary> 🛠️ <b>Development</b> </summary>

- **Telemetry:** Blocks all tracking.
- **Restrictions:** Keeps **Developer Tools** enabled while disabling all other Brave-specific distractions.
- **Brave Features:** Disables Rewards and Wallet but retains Sync if needed.
- **Best for:** Web developers and power users.
</details>

---

## 🚀 Key Features

<details>
<summary> View Full Policy List </summary>

#### 📊 Telemetry & Reporting
- **Disable Metrics Reporting:** Stops usage stats and crash reports.
- **Disable Safe Browsing Reporting:** Stops sending threat data to Google/Brave.
- **Disable URL Data Collection:** Prevents anonymized URL tracking.
- **Disable Feedback Surveys:** Blocks pop-up feedback requests.

#### 🛡️ Privacy & Security
- **WebRTC IP Leak Protection:** Blocks non-proxied UDP to hide your real IP.
- **Block Third Party Cookies:** Native blocking of cross-site trackers.
- **SafeSearch & Safe Browsing:** Force strict content filtering and malware protection.
- **Access Control:** Toggle Autofill, Password Manager, and Incognito Mode.

#### 🦁 Brave Feature Control
- **Crypto-Free:** Disable Brave Rewards (BAT) and the integrated Wallet.
- **AI-Free:** Completely remove Leo AI Chat from the sidebar and settings.
- **Service Cleanup:** Disable Brave VPN, Sync, and Tor private windows.
- **Shields Toggle:** Option to disable Brave Shields globally via policy.

#### ⚙️ Performance & Bloat
- **Zero Background:** Stops Brave from running processes after it's closed.
- **No Suggestions:** Disables search suggestions and media "recommendations" on New Tabs.
- **UI Cleanup:** Removes shopping lists, promotions, and print capabilities.
- **Developer Lock:** Optional toggle to disable F12 / Inspect Element for kiosk-mode setups.
</details>

---

## 🛠️ System Requirements

- **OS:** Windows 10 or 11
- **Privileges:** Administrator (required to write to `HKLM` Registry)
- **Dependencies:** `logo.png` in the same directory (optional, for branding)

---

## 🖥️ How to Run

Open **PowerShell as Administrator** and paste the following command to download and run the latest version:

```powershell
iwr "[https://raw.githubusercontent.com/MattJF7/LeanBrave/main/LeanBrave.ps1](https://raw.githubusercontent.com/MattJF7/LeanBrave/main/LeanBrave.ps1)" -OutFile "LeanBrave.ps1"; iwr "[https://raw.githubusercontent.com/MattJF7/LeanBrave/main/logo.png](https://raw.githubusercontent.com/MattJF7/LeanBrave/main/logo.png)" -OutFile "logo.png"; .\LeanBrave.ps1
