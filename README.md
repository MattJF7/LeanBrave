<div align="center">

# LeanBrave
<img width="200" height="300" alt="Image" src="https://github.com/user-attachments/assets/efb87da3-ca24-413f-b30c-605268828f10" />

---

## Brave Browser Debloater

LeanBrave is a PowerShell script that declutters the Brave Browser. It allows you to quickly toggle features on or off, optimizing your settings for better privacy and a cleaner experience.

</div>

### 📂 Configuration Presets

Choose a configuration that matches your needs:

<details>
<summary> 🌑 <b>Maximum Privacy</b> </summary>

- **Telemetry:** Blocks all reporting (metrics, safe browsing, URL collection, feedback).
- **Privacy:** Disables autofill, password manager, sign-in, WebRTC leaks, QUIC, and forces Do Not Track.
- **Brave Features:** Kills Rewards, Wallet, VPN, AI Chat, Tor, and Sync.
- **Performance:** Disables background processes, recommendations, and bloat.
- **DNS:** Uses plain DNS (Off) to prevent potential logging by DoH providers.
- **Best for:** Paranoid users, journalists, or activists.
</details>

<details>
<summary> 🌗 <b>Balanced Privacy</b> </summary>

- **Telemetry:** Blocks all tracking but keeps basic safe browsing.
- **Privacy:** Blocks third-party cookies, enables Do Not Track; allows password manager and autofill.
- **Brave Features:** Disables Rewards, Wallet, VPN, and AI features.
- **Performance:** Turns off background services and ads.
- **DNS:** Uses automatic DoH.
- **Best for:** Most users who want privacy with convenience.
</details>

<details>
<summary> ⚡ <b>Performance Focused</b> </summary>

- **Telemetry:** Only blocks metrics and feedback surveys.
- **Brave Features:** Disables Rewards, Wallet, VPN, and AI to declutter.
- **Performance:** Kills background processes, shopping features, and promotions.
- **DNS:** Automatic DoH for speed and security.
- **Best for:** Users who want a faster, cleaner browser.
</details>

<details>
<summary> 🛠️ <b>Developer Preset</b> </summary>

- **Telemetry:** Blocks all reporting.
- **Brave Features:** Disables Rewards, Wallet, and VPN; **keeps developer tools**.
- **Performance:** Turns off background services and ads.
- **DNS:** Automatic DoH.
- **Best for:** Developers who need dev tools but hate telemetry.
</details>

---

### Features:

<details>
<summary> Click here to view organized features </summary>

#### 📊 Telemetry & Reporting
- **Disable Metrics Reporting:** Stops Brave from sending usage statistics.
- **Disable Safe Browsing Reporting:** Prevents sending data about potentially unsafe sites.
- **Disable URL Data Collection:** Stops the collection of anonymized URL-keyed data.
- **Disable Feedback Surveys:** Removes intrusive requests for browser feedback.

#### 🛡️ Privacy & Security
- **Enable Do Not Track:** Forces the "Do Not Track" header for all browsing sessions.
- **WebRTC IP Leak Protection:** Disables non-proxied UDP to prevent your real IP from leaking.
- **Block Third-Party Cookies:** Increases privacy by preventing tracking across different sites.
- **Disable Password Manager:** Turns off the built-in manager.
- **Disable Autofill:** Stops the browser from storing addresses and credit card info.
- **Disable Browser Sign-in:** Prevents prompts to sign into a Brave account.
- **Force Google SafeSearch:** Enforces strict filtering on Google results.
- **Incognito Mode Control:** Option to disable private browsing entirely.

#### 🚀 Brave-Specific Bloat
- **Disable Brave Rewards:** Removes the BAT/Rewards system.
- **Disable Brave Wallet:** Completely disables the integrated crypto wallet.
- **Disable Brave VPN:** Removes the VPN button and services.
- **Disable Brave AI Chat:** Turns off the "Leo" AI integration.
- **Disable Tor:** Removes the ability to open private windows with Tor.
- **Disable Brave Shields:** Option to turn off the built-in ad-blocker.

#### ⚙️ Performance & Cleanup
- **Disable Background Mode:** Stops Brave from running after the window is closed.
- **Disable Search Suggestions:** Prevents sending keystrokes to the search engine.
- **Disable Media Recommendations:** Removes suggested content.
- **Disable Spellcheck:** Disables the built-in dictionary service.
- **Disable IPFS:** Turns off InterPlanetary File System support.
- **Always Open PDF Externally:** Forces PDFs to open in your system viewer.

#### 🛠️ System & Restrictions
- **Set DNS Over HTTPS Mode:** Configure secure DNS (Automatic, Off, or Custom).
- **Disable Sync:** Stops cross-device data synchronization.
- **Disable Printing:** Blocks web page printing.
- **Disable Developer Tools:** Prevents access to F12 / Inspect Element.
- **Disable Default Browser Prompt:** Stops Brave from nagging you.
</details>

---

# How to Run

### Run the command below in PowerShell (Admin):

```ps1
iwr "https://raw.githubusercontent.com/MattJF7/LeanBrave/main/LeanBrave.ps1" -OutFile "LeanBrave.ps1"; iwr "https://raw.githubusercontent.com/MattJF7/LeanBrave/main/logo.png" -OutFile "logo.png"; .\LeanBrave.ps1
