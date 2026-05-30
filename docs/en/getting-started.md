# Quick Start Guide - Launch the Full Private Stack

Start fast, run clean, and unlock the private workflow in minutes.

> **Note:** This is a private repository. You need approved access before installing.
> Contact the repo owner to get invited and unlock the full private setup.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Install](#install)
  - [Step 1 - Verify private access](#step-1--verify-private-access)
  - [Step 2 - Run the installer](#step-2--run-the-installer)
- [After Installation](#after-installation)
  - [Step 2.5 — Adaptive skills + custom workflow extensions](#step-25--adaptive-skills--custom-workflow-extensions)
  - [Main Recommendation: Use OpenCode VSCode Extension by SST](#main-recommendation-use-opencode-vscode-extension-by-sst)
  - [🌐 Secondary Option: Web UI](#-secondary-option-web-ui)
  - [Checking your quota](#checking-your-quota)
  - [Account issues: `[needs verification]` or `[disabled]`](#account-issues-needs-verification-or-disabled)
  - [New Google account setup: enable Gemini Pro/Ultra APIs](#new-google-account-setup-enable-gemini-proultra-apis)
- [Adding Multiple Accounts (Safe Method)](#adding-multiple-accounts-safe-method)
  - [Step-by-step](#step-by-step)
  - [Summary](#summary)
  - [Account selection workaround (safe mode)](#account-selection-workaround-safe-mode)
  - [Quick FAQ: disable/change account/limit](#quick-faq-disablechange-accountlimit)
- [Choosing a Profile](#choosing-a-profile)
  - [Resource Mode (low / balanced / performance)](#resource-mode-low--balanced--performance)
  - [Quick Selection Matrix](#quick-selection-matrix)
  - [Profile Decision Tree](#profile-decision-tree)
  - [Choosing an Agent Mode (Sisyphus, Hephaestus, Prometheus, Atlas)](#choosing-an-agent-mode-sisyphus-hephaestus-prometheus-atlas)
  - [After changing profile (important)](#after-changing-profile-important)
- [Updating](#updating)
- [Plugin Stack](#plugin-stack)
  - [Dynamic Context Pruning (DCP)](#dynamic-context-pruning-dcp)
  - [Safety Net (`cc-safety-net`)](#safety-net-cc-safety-net)
  - [Optional Plugins](#optional-plugins)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

Install **GitHub CLI** — this is required to verify private release repo access:

- **Windows (normal)**: `winget install --id GitHub.cli -e`
- **Windows (no winget / Ghost Spectre)**: Download the `.msi` installer directly → [cli.github.com/releases](https://github.com/cli/cli/releases/latest)
- **macOS**: `brew install gh`
- **Linux**: See [cli.github.com](https://cli.github.com)

> **Ghost Spectre / debloated Windows users:** `winget` is not available on stripped Windows ISOs.
> On the releases page, pick the file that matches your system:
>
> | Your PC                            | File to download                   |
> | ---------------------------------- | ---------------------------------- |
> | Windows 64-bit (most PCs)          | `gh_*_windows_amd64_installer.msi` |
> | Windows 32-bit (old PC)            | `gh_*_windows_386_installer.msi`   |
> | Windows on ARM (Surface Pro X etc) | `gh_*_windows_arm64_installer.msi` |
>
> **Not sure?** Pick `gh_*_windows_amd64_installer.msi` — it's correct for 99% of PCs.
>
> Alternatively, the installer script will install missing tools automatically when possible, so you can continue directly to Step 2.

Then authenticate (required for private repo access):

```bash
gh auth login -h github.com -w
```

---

## Install

### Step 1 — Verify private access

```bash
gh repo view andyvandaric/opencode-config-suites-releases
```

If `gh repo view` fails, your current GitHub account has no access to this private repo yet.
Login again with the invited account, then retry:

```bash
gh auth login -h github.com -w
```

### Step 2 — Run the installer

**Windows (PowerShell):**

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex"
```

Install a specific version:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command '$env:OCS_VERSION = "3.0.0"; irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex'
```

**Linux / macOS (Bash):**

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.sh | bash
```

Install a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.sh | bash -s -- --version 3.0.0
```

The script automatically:

- Installs **Git**, **Bun**, and **GitHub CLI** if missing
- Removes any conflicting `opencode-antigravity-auth` plugin
- Runs `bun install` and deploys your config
- Installs the **OpenCode CLI**
- Installs/repairs native compression helpers, including the Windows OCS-managed `grep.exe` shim under `.opencode/bin` required by `rtk grep`
- Auto-installs **CocoIndex** (Python + pip path), writes `~/.config/opencode/cocoindex/.env`, and seeds `postgres.compose.yml` for local startup

---

## After Installation

Add your account:

```bash
opencode auth login
```

- **Antigravity**: Choose **Google** → wait for all panels to **fully load** before proceeding — do not press Enter too early while it is still loading.
- **OpenAI Codex**: Choose **OpenAI** — login via browser.

### Step 2.5 — Adaptive skills + custom workflow extensions

OCS automatically initializes user-owned extension scaffolds at:

- `~/.config/opencode/extensions/README.md`
- `~/.config/opencode/extensions/skills/README.md`
- `~/.config/opencode/extensions/rulesets/README.md`
- `~/.config/opencode/extensions/workflow/README.md`

Recommended high-precision operating model:

1. Keep OCS-managed baseline skills in `~/.config/opencode/skills`.
2. Add custom rules/skills/workflow only under `~/.config/opencode/extensions/*`.
3. Use adaptive minimum-sufficient loading (domain baseline first, add extras only for explicit risk triggers).

Built-in bundle mental model:

- **Routing**: `frontend-ui-ux`, `ocs-parallel-orchestration-grooming`
- **Context**: `ocs-product-marketing-context`
- **Execution**: `ocs-lsp-bootstrap`, `ocs-cocoindex-bootstrap`, `ocs-technical-copy-seo`
- **Audit**: `ocs-seo-audit`
- **Verification**: `ocs-runtime-validation`, `ocs-tdd-rgr-regression-guard`, `ocs-markdown-autofix`
- **Modifier**: `impeccable-style`

Safe combination examples:

- Product positioning setup: `ocs-product-marketing-context`
- Technical copy rewrite: `ocs-product-marketing-context` -> `ocs-technical-copy-seo` -> `ocs-markdown-autofix`
- SEO diagnosis: `ocs-product-marketing-context` -> `ocs-seo-audit`
- Visual redesign or UI cleanup: `frontend-ui-ux` -> optional `impeccable-style`
- Behavioral bug fix or risky refactor: `ocs-tdd-rgr-regression-guard` -> add `ocs-runtime-validation` only when the risk is environment-sensitive
- CocoIndex recovery: `ocs-cocoindex-bootstrap` -> `ocs-runtime-validation` when final runtime proof matters

Practical study case:

- [Adaptive Skills Case Study (ClawSkills integration)](./adaptive-skills-clawskills-case-study.md)
- Includes copy-paste user request templates to ask agents to install + activate the right skill automatically.
- For markdown-heavy plans/docs, load `ocs-markdown-autofix` so agents prefer repo-local `lint:md:fix` + `lint:md`, otherwise fall back to `bunx markdownlint-cli2`, then `npx markdownlint-cli2`, and fail clearly if no supported runner exists.

### Step 2.8 — Advanced: CocoIndex troubleshooting (agent/project scoped)

Most users can ignore this section. CocoIndex is intended for project-scoped semantic retrieval when an agent/task explicitly needs it. It is not a default post-install step, and it should never be aimed at your global `~/.config/opencode` directory.

When a real workspace needs CocoIndex and the managed wrapper path looks unhealthy, use the supported ladder below.

- `ocs index status` is the first troubleshooting step: confirm the MCP server is registered, healthy, and ready for the current project.
- `ocs index start [--force] [--wait] [--timeout <seconds>]` boots the CocoIndex stack (Python, `ccc`, Postgres) that setup has already prepared for that workspace.
- `ocs index logs --tail <lines> --follow` streams the `ccc mcp` STDIO output so you can watch dependency checks, indexing progress, and network handshakes. `--tail 200 --follow` is a reliable default pair.
- `ocs index doctor` runs the runtime-aware health checks and remediation hooks built into the MCP shell.
- `ocs index rebuild --force` reindexes the current project. Add `--hard-reset` only when you plan to delete every `.mdb` file for that project and start from scratch (last resort).
- `ocs index stop [--timeout <seconds>] [--force]` shuts down the MCP server cleanly so you can restart or update it.

Follow the ladder: status → start → logs → doctor → rebuild, and rely on `stop` only when you intend to restart the service.

#### Edge-case recovery — profile applied but models/MCP look stale

If `ocs setup profile` succeeds but Web UI still shows old model routing (or CocoIndex MCP is missing), run this recovery sequence in the **same shell/environment** you use to launch OpenCode:

1. Re-run profile apply:
   - `ocs setup profile`
2. Refresh model catalog:
   - `opencode models --refresh`
3. Rehydrate CocoIndex MCP registration/runtime for the current workspace:
   - `ocs index status`
   - If missing/unhealthy: `ocs index start --force --wait`
4. Fully restart runtime (required):
   - Stop `opencode web` (`Ctrl+C`)
   - Start again with the same port

WSL note: if you run OpenCode from WSL, do setup + refresh + launch from WSL as one consistent flow. Avoid mixing setup in one environment and runtime in another.


For the dedicated CocoIndex operations playbook and MCP-inactive fallback sequence, see [CocoIndex operations guide](./cocoindex-ops-en.md). Treat that guide as advanced troubleshooting for project-scoped indexing, not a default onboarding step.

### Main Recommendation: Use OpenCode VSCode Extension by SST

For long-running sessions, we strongly recommend using the **OpenCode VSCode Extension by SST** because runtime follows the VS Code process lifecycle and is generally more stable for sustained use.

1. Open VS Code.
2. Go to the Extensions tab (`Ctrl+Shift+X` / `Cmd+Shift+X`), search for **"opencode"** (Publisher: SST), and install it.
3. Open your project folder in VS Code.
4. Click the OpenCode icon in the sidebar and select your desired **Agent Profile**.
5. You **do not** need to configure API keys in VS Code settings because `opencode auth login` handles it globally.

### 🌐 Secondary Option: Web UI

If you want browser-first multi-tab supervision, Web UI remains fully supported:

1. Open a terminal in your project folder (workspace root):

```bash
# Windows
cd %USERPROFILE%\Dev\MyProject
opencode web --port 8089

# macOS / Linux
cd ~/Dev/MyProject
opencode web --port 8089
```

_(Note: You can change the `--port` number as desired)._

1. Open `localhost:8089` in your browser.
2. In the browser UI, click **Load Project** / **Open Folder** and select your project folder (if not automatically opened).
3. **Done!** You are ready to interact with Agents and Sub-Agents efficiently.

_Note: The Web UI may cache settings. If you manually edit `.json` configuration files, stop the server (`Ctrl+C`) and start it again for changes to apply._

In Web UI, you can open **Sub-Agent conversations in a new tab** (`right-click -> Open in New Tab`) for parallel oversight.

### Checking your quota

To see remaining quota for all accounts:

1. Run `opencode auth login`
2. Select **Google** → **OAuth with Google (Antigravity)**
3. Select **Check quotas**

You'll see a breakdown per account showing Gemini CLI and Antigravity quota (Claude, Gemini 3.1 Pro, Gemini 3 Flash) with a progress bar and reset timer for each.

### OpenAI (ChatGPT) multi-account onboarding (CLI demo)

Use this flow to add and manage OpenAI accounts professionally and safely.

#### Add a ChatGPT account

```bash
opencode auth login -p openai
```

When the menu appears:

1. Open **OpenAI accounts**.
2. Select **ChatGPT Pro/Plus (browser)**.
3. Copy the generated URL and open it in a clean browser profile that is already signed in to ChatGPT.
4. Complete login and choose the intended workspace (for example, Business workspace when applicable).
5. After redirect/fallback appears in the browser, copy the **full final URL** and paste it back into the CLI prompt.
6. Press Enter to finalize account import.

#### Manage multi-account and check quotas

Run the same command and use the account-management menu:

```bash
opencode auth login -p openai
```

- **Add account**: onboard another ChatGPT account.
- **Manage accounts**: enable/disable or remove specific accounts.
- **Check quotas**: inspect remaining quota/limits across configured OpenAI accounts.

#### Example CLI session (illustrative)

```text
$ opencode auth login -p openai
┌ OpenAI accounts
◆ Select an account-management action
│ ● ChatGPT Pro/Plus (browser)

[CLI prints login URL]
[You open URL in browser profile already logged into ChatGPT]
[You complete login and copy final fallback URL]

Paste callback URL:
https://chat.openai.com/...<full callback URL>...

✅ Account imported successfully
```

### Account issues: `[needs verification]` or `[disabled]`

Some accounts may show `[needs verification] [disabled]` in the account list. This means Google has flagged the account and it cannot be used until verified.

**Verification via Antigravity Manager (recommended):**

- Use the [Antigravity Manager](https://github.com/lbjlaq/Antigravity-Manager/blob/main/README_EN.md) tool via Antigravity IDE to attempt verification.
- Note: verification **cannot** be done directly from inside OpenCode — you must use the external tool.

**If the account cannot be verified:**

1. Delete the problematic account from the list (`opencode auth login` → select the account → delete)
2. Add a fresh account in its place
3. The new account should work immediately

**If verification succeeds via Antigravity IDE:**

1. Go back to `opencode auth login` → select the previously problematic account → delete it
2. Re-add the same account
3. It should now work normally

### New Google account setup: enable Gemini Pro/Ultra APIs

Some new Google Cloud projects cannot use Gemini Pro/Ultra until required APIs are enabled.

1. Open Google Cloud Console (`https://console.cloud.google.com/`).
   - Create a new project if you don't have one, or select an existing project.
   - Make sure you are in the correct project, then **Copy your Project ID**.
2. Enable all required APIs by replacing `<projectid>` in the links below with your actual Project ID (then click **Enable** on each page):
   - **Gemini for Google Cloud API:**
     `https://console.cloud.google.com/apis/library/cloudaicompanion.googleapis.com?project=<projectid>`
   - **Vertex AI API:**
     `https://console.cloud.google.com/apis/library/aiplatform.googleapis.com?project=<projectid>`
   - **Generative Language API:**
     `https://console.cloud.google.com/apis/library/generativelanguage.googleapis.com?project=<projectid>`
3. Verify status in the API dashboard:
   - Open `https://console.cloud.google.com/apis/dashboard?project=<projectid>`
   - Ensure all 3 APIs are enabled for the correct project.
4. If prompted, enable Billing for that project
5. Restart your OpenCode auth session:
   - Stop running OpenCode (`Ctrl+C`)
   - Run `opencode auth login` again
   - Start OpenCode again with the same port (for example: `opencode web --port 8089`)

If you still see `PERMISSION_DENIED` or API-not-enabled errors, wait 2-10 minutes (propagation delay), then re-login and retry.

## Adding Multiple Accounts (Safe Method)

> **Important:** To keep your Google accounts safe, follow this method when adding multiple accounts.

Each account should be logged in from a **unique IP address**. Logging in multiple accounts from the same IP repeatedly can trigger Google's suspicious activity detection.

### Step-by-step

**1. Prepare separate Chrome profiles**

Create one Chrome profile per account:

- Open Chrome → click your profile icon (top right) → **Add**
- Give each profile a name (e.g. Account 1, Account 2, ...)
- Each profile has its own isolated cookies and session — Google sees them as separate browsers

**2. Use mobile hotspot (tethering)**

Connect your PC to your phone's hotspot instead of WiFi/LAN. Mobile IPs are dynamic and rotate easily.

**3. Change IP between each account login**

Before logging in each new account:

1. Enable **Airplane Mode** on your phone for ~10 seconds
2. Disable Airplane Mode — your phone gets a fresh IP
3. Log in the next account using `opencode auth login` in that Chrome profile

> **Rule: 1 account = 1 IP**
> Never log in two different accounts from the same IP in the same session.

### Summary

| Step | Action                                           |
| ---- | ------------------------------------------------ |
| 1    | Open a dedicated Chrome profile for this account |
| 2    | Connect PC to phone hotspot                      |
| 3    | Airplane mode on phone 10s → off (get new IP)    |
| 4    | Run `opencode auth login` → choose Google        |
| 5    | Repeat from step 1 for each additional account   |

### Account selection workaround (safe mode)

Do **not** keep only one account enabled for long sessions. That can drain quota quickly and increase risk of `403 Forbidden`.

Safer approach: keep multiple healthy accounts enabled, disable only problematic ones.

1. Run `opencode auth login`
2. In account management:
   - problematic accounts (rate-limited / needs verification / unstable): **Disable**
   - healthy accounts: **Enable** (recommended: at least 6)
3. Restart OpenCode session:
   - stop current process with `Ctrl+C`
   - run `opencode web --port 8089` (use the same port you were using)

This keeps auto-rotation active across healthy accounts so quota lasts longer and failures are reduced.

Only use single-account mode briefly for debugging/testing, then re-enable other healthy accounts.

### Quick FAQ: disable/change account/limit

- How do I temporarily disable `oh-my-openagent` account usage?
  - Run `opencode auth login` -> open account management -> set problematic account to **Disable**.
- When should I change account?
  - Switch when current account hits rate-limit, shows `needs verification`, becomes unstable, or returns repeated `403` errors.
- What is the practical limit before rotating?
  - There is no single fixed number for all users. Follow quota status (`Check quotas`) and rotate as soon as one account approaches limit.
  - Recommended operational baseline: keep at least 6 healthy accounts enabled for safer rotation.

---

## Choosing a Profile

During setup (`bun run setup:profile`), you'll be prompted to pick a profile:

Need a fast non-interactive switch (no prompt)? Run:

```bash
ocs setup:profile --profile gemini-3-all --headless
```

| #   | Profile                    | Main Brain                 | Best For                                                              |
| --- | -------------------------- | -------------------------- | --------------------------------------------------------------------- |
| 1   | `gpt-5.4-best-perform`     | GPT 5.4 + Codex 5.3        | Recommended daily default: highest-quality default for critical work. |
| 2   | `codex-5.3-token-saver`    | Codex 5.3 + Codex 5.1 Mini | Codex-first backup for lower-cost daily throughput.                   |
| 3   | `gpt-5.4-token-saver`      | GPT 5.4 + Codex 5.1 Mini   | GPT backup profile with lower worker token spend.                     |
| 4   | `glm-4.7-lite-token-saver` | GLM 4.7 + GLM family mix   | Lightweight mixed strategy for lower-cost throughput.                 |
| 5   | `codex-5.3-hybrid`         | Codex + Gemini + Sonnet    | Balanced Codex-led mixed worker strategy.                             |
| 6   | `codex-5.3-all`            | GPT 5.3 Codex              | All agents and categories on Codex.                                   |
| 7   | `codex-5.3-gemini`         | Codex + Gemini             | Codex-heavy: Codex orchestration + Gemini workers.                    |
| 8   | `codex-5.3-sonnet-4.6`     | Codex + Sonnet 4.6         | Codex primary with Sonnet quality-focused worker path.                |
| 9   | `gemini-3-all`             | Gemini 3.1 Pro + 3 Flash   | **Gemini-only.** Fast lane, no Claude usage.                          |
| 10  | `opus-4.6-lead`            | Opus + mixed workers       | **Lead profile.** Maximum critical-role accuracy.                     |
| 11  | `sonnet-4.6-lead`          | Sonnet + mixed workers     | **Lead profile.** Balanced Claude-led daily flow.                     |
| 12  | `sonnet-4.6-all`           | Sonnet 4.6 Thinking        | **All profile.** Single-family Sonnet setup.                          |

**Recommended start:**

- Daily default (best-perform) -> `gpt-5.4-best-perform`
- Need lower-cost Codex backup -> `codex-5.3-token-saver`
- Need GPT backup with lower worker token spend -> `gpt-5.4-token-saver`

### Resource Mode (low / balanced / performance)

After selecting a profile, setup asks you to pick a resource mode. This controls how much compute pressure OpenCode puts on your machine by adjusting agent thinking depth and variant intensity.

| Mode          | Best for                                      | What changes                                                                  |  Concurrent agents  |
| ------------- | --------------------------------------------- | ----------------------------------------------------------------------------- | :-----------------: |
| `low`         | Laptop, many apps open, battery saving        | Heavy agents downgraded to `low`/`minimal` variants. Flash workers stay fast. | ~40% of spare cores |
| `balanced`    | Daily coding, most users (default)            | Profile defaults used as-is. No variant overrides applied.                    | ~80% of spare cores |
| `performance` | Architecture, deep debugging, large refactors | Critical roles upgraded to `max`/`high` variants.                             |   spare cores − 1   |

> **Quick pick:**
>
> - Laptop / browser + IDE open → `low`
> - Normal daily work → `balanced`
> - Hard problem, complex task → `performance`

> **Concurrent agents formula:** `spareCores = totalCores − 2` (2 cores reserved for OS + OpenCode). Setup writes the limit into the installed `~/.config/opencode/oh-my-opencode.json` / `oh-my-openagent.json` compatibility files.

**What `low` mode actually does:**

| Agent / Category                         | Normal variant  | `low` mode variant |
| ---------------------------------------- | --------------- | ------------------ |
| `sisyphus`, `oracle`, `atlas`            | `max` / `high`  | `low`              |
| `explore`, `quick`, `unspecified-low`    | `high` / `none` | `minimal`          |
| `librarian`, `implementation`, `testing` | varies          | `low`              |
| `deep`, `ultrabrain`                     | `max`           | `low`              |

> You can re-run setup anytime to switch mode without changing profile.

### Quick Selection Matrix

| Use case                             | Profile                 | Why                                                                          |
| ------------------------------------ | ----------------------- | ---------------------------------------------------------------------------- |
| Best all-round daily default         | `gpt-5.4-best-perform`  | GPT 5.4 leads by default while Codex 5.3 stays available for strong worker throughput. |
| GPT backup for highest quality       | `gpt-5.4-best-perform`  | Uses GPT-5.4 for core/deep lanes and Codex 5.3 for fast lanes.               |
| GPT backup with lower token spend    | `gpt-5.4-token-saver`   | Keeps GPT-5.4 for critical decisions, shifts worker lanes to Codex 5.1 Mini. |
| Balanced mixed quality/speed         | `codex-5.3-hybrid`      | Codex orchestration with Gemini + Sonnet worker mix.                         |
| One-family Codex stack               | `codex-5.3-all`         | All agents/categories stay in Codex family.                                  |
| Codex-first + strong Gemini research | `codex-5.3-gemini`      | Codex leads, Gemini handles most worker/research load.                       |
| Codex + Sonnet only                  | `codex-5.3-sonnet-4.6`  | Two-family setup focused on Codex + Sonnet quality path.                     |
| Fast Gemini-only throughput          | `gemini-3-all`          | Single Gemini family (3.1 Pro + 3 Flash), no Claude usage.                   |
| Maximum critical-role accuracy       | `opus-4.6-lead`         | Opus leads critical roles, mixed workers keep throughput practical.          |
| Claude-led balanced mixed stack      | `sonnet-4.6-lead`       | Sonnet leads core roles with mixed workers for efficiency.                   |
| Single-family Sonnet stack           | `sonnet-4.6-all`        | All agents/categories stay in Sonnet family.                                 |

### Profile Decision Tree

Use this quick path when you're unsure:

1. Need one model family for all agents/categories?
   - Yes -> `codex-5.3-all`, `gemini-3-all`, or `sonnet-4.6-all`
   - No -> continue
2. Need the highest-quality daily default?
   - Yes -> `gpt-5.4-best-perform`
   - No -> continue
3. Need GPT-5.4 as backup for critical quality lanes?
   - Yes -> choose one:
     - `gpt-5.4-best-perform` for maximum quality
     - `gpt-5.4-token-saver` for lower worker token spend
   - No -> continue
4. Need GLM lightweight mixed strategy?
   - Yes -> `glm-4.7-lite-token-saver`
   - No -> continue
5. Prefer Codex as primary brain?
   - Yes -> choose one:
     - `codex-5.3-hybrid` (Codex + Gemini + Sonnet workers)
     - `codex-5.3-all` (single-family Codex)
     - `codex-5.3-gemini` (Codex + Gemini workers)
     - `codex-5.3-sonnet-4.6` (Codex + Sonnet only)
   - No -> continue
6. Need highest accuracy for critical roles (architect/debug/security)?
   - Yes -> `opus-4.6-lead`
   - No -> continue
7. Need balanced Claude-led flow with mixed workers?
   - Yes -> `sonnet-4.6-lead`
8. If still unsure, start with `gpt-5.4-best-perform`, then switch to `codex-5.3-token-saver` when you want a lower-cost Codex-first backup.

### Choosing an Agent Mode (Sisyphus, Hephaestus, Prometheus, Atlas)

When your UI shows multiple agent modes, use this quick mapping:

| Agent mode   | Best use case                                                       | Example prompt                                                        |
| ------------ | ------------------------------------------------------------------- | --------------------------------------------------------------------- |
| `Sisyphus`   | General daily driver, end-to-end implementation, balanced execution | "Implement this feature and run full verification."                   |
| `Hephaestus` | Deep engineering execution, hard debugging, complex refactors       | "Trace this flaky bug and deliver a root-cause fix."                  |
| `Prometheus` | Planning and architecture before coding                             | "Create a concrete implementation plan with risks and milestones."    |
| `Atlas`      | Large execution workload, multi-step task batches                   | "Execute this checklist across modules and report progress by phase." |

If you see variants (for example planning/executor focused labels in the dropdown), pick by intent:

- planning-focused variant -> use before coding
- executor-focused variant -> use when plan is already clear and you want fast delivery
- deep-analysis variant -> use for unclear failures or high-risk changes

Quick recommendation for new users:

1. Start with `Sisyphus`
2. Switch to `Prometheus` when you need a better plan
3. Switch to `Hephaestus` for deep debugging
4. Switch to `Atlas` for large batched execution

### After changing profile (important)

If `opencode web` is already running and you switch profile with `bun run setup:profile` or `bun run setup:profile:update`:

1. Stop the current OpenCode process in that terminal (`Ctrl+C`)
2. Start OpenCode again using the same port as before

```bash
opencode web --port 8089
```

Using a different port by accident can make it look like config changes did not apply.

If the same port still fails right after `Ctrl+C` (port appears blocked on Windows), run:

```powershell
taskkill /IM node.exe /F
```

Then start OpenCode again on the same port:

```bash
opencode web --port 8089
```

---

## Updating

When a new version is released, run this from your repository folder.

**Option A — Standard update** (safe, preserves any local tweaks):

```bash
git pull --ff-only origin main
bun run setup:profile:update
```

`git pull --ff-only` fetches the latest version without rewriting local history. If your local branch has diverged from remote (e.g. you accidentally committed something), this command will abort and ask you to resolve the conflict first. The generated `oh-my-opencode.json` / `oh-my-openagent.json` files are installed under `~/.config/opencode/`, not kept at the repository root.

**Option B — Hard reset update** (recommended for most users — always in sync with remote):

```bash
git fetch origin
git reset --hard origin/main
bun run setup:profile:update
```

`git fetch` downloads the latest state from remote without touching your local files. `git reset --hard` then forces your local copy to be **identical** to remote — any local changes, accidental edits, or uncommitted modifications are wiped. This never fails due to divergence and is the safest choice if you never intentionally modify files in this repo.

> **⚠️ IMPORTANT:** After running the update, you MUST restart your OpenCode session. Go to the terminal where `opencode web` is running, press `Ctrl+C` to stop it, and start it again with the same port (e.g., `opencode web --port 8089`).

---

## Plugin Stack

This config ships with four plugins pre-configured in `opencode.json`:

| Plugin                           | Role                                                             | API key required? |
| -------------------------------- | ---------------------------------------------------------------- | :---------------: |
| `oh-my-openagent`                | Multi-agent routing and 14 specialized agents                    |        No         |
| `@tarquinen/opencode-dcp`        | Dynamic Context Pruning — reduces token usage automatically      |        No         |
| `cc-safety-net`                  | Safety hook — blocks destructive shell commands before execution |        No         |
| `@ramtinj95/opencode-tokenscope` | Token & cost analytics with per-agent breakdown                  |        No         |

> ⚠️ **Restart required:** All four plugins activate automatically — but only after a full OpenCode restart. If you add plugins to `opencode.json` while OpenCode is already running, you must **kill the process and restart it** for the new plugins to be downloaded and loaded. A config reload alone is not enough.

> **Plugin installation is handled automatically by setup.** Running `bun run setup:profile:update` installs all plugins into `~/.config/opencode/node_modules`. You do not need to run `bun install` manually.

No extra configuration is needed beyond the restart.

### Dynamic Context Pruning (DCP)

DCP silently removes stale content from conversation history before each LLM request — duplicate file reads, superseded writes, and old errors — without touching your session on disk. This reduces token usage on long coding sessions at zero cost.

**Useful slash commands** (type in the OpenCode chat box):

| Command         | What it does                                        |
| --------------- | --------------------------------------------------- |
| `/dcp`          | Show DCP help and available commands                |
| `/dcp context`  | Show current context size and what DCP has pruned   |
| `/dcp stats`    | Full pruning statistics for this session            |
| `/dcp sweep`    | Manually trigger a pruning pass                     |
| `/dcp distill`  | Distill a portion of history into a summary         |
| `/dcp compress` | Compress conversation history to reduce token count |
| `/dcp prune`    | Manually prune specific items from context          |
| `/dcp manual`   | Open DCP manual / full documentation                |

Optional: create `~/.config/opencode/dcp.jsonc` for custom settings (compression thresholds, protected tools list). Defaults work well without it.

If you see `DCP: Invalid config` with unknown keys like `pruningStrategies.*`, your file contains legacy keys. Back up `~/.config/opencode/dcp.jsonc`, then reset it to:

```jsonc
{
  "$schema": "https://raw.githubusercontent.com/Opencode-DCP/opencode-dynamic-context-pruning/master/dcp.schema.json",
}
```

### Safety Net (`cc-safety-net`)

A PreToolUse hook that intercepts Bash commands before the LLM executes them. It blocks operations known to cause irreversible damage:

- `git reset --hard`
- `rm -rf` outside current working directory
- `git push --force` to main/master
- Shell wrapper bypasses (e.g. `bash -c "rm ..."`)
- Interpreter one-liners that circumvent hook inspection

If a blocked command is intentional, you will be prompted to confirm before execution.

**Verify it's active** after install:

```bash
npx cc-safety-net doctor
```

### Optional Plugins

These plugins ship pre-configured in your `opencode.json`. **No setup needed** — they install automatically the first time OpenCode starts after your setup runs.

#### `@ramtinj95/opencode-tokenscope` — Token & Cost Analytics

Tracks token usage per session with ASCII charts, per-agent cost breakdown, and pricing for 41+ models. Useful for understanding your consumption across long sessions. **No setup needed** — active automatically after your first restart.

> **Note for Antigravity users**: Cost estimates reflect public pay-per-token pricing, not your actual subscription cost.

---

## Troubleshooting

| Problem                                                             | Solution                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `404 Not Found` on repo check                                       | You don't have repo access — contact the owner to get invited                                                                                                                                                                                                                                                                            |
| `gh: command not found`                                             | Install GitHub CLI first: [cli.github.com](https://cli.github.com)                                                                                                                                                                                                                                                                       |
| `bun: command not found`                                            | Install from [bun.sh](https://bun.sh), restart terminal                                                                                                                                                                                                                                                                                  |
| `ocs` or `opencode: command not found`                              | Open a new terminal first. On macOS/Linux run `ocs doctor`, then `ocs doctor --fix` if remediation is offered. Only use a temporary `export PATH=... && hash -r` as an emergency fallback while investigating why the persisted shell snippet was not loaded. On Windows open a new PowerShell, run `Get-Command ocs`, `Get-Command opencode`, then `ocs doctor` (or `ocs doctor --fix`). |
| `Authentication failed` on repo check                               | Run `gh auth login -h github.com -w` and make sure you're using the invited account                                                                                                                                                                                                                                                      |
| `GraphQL: Could not resolve to a Repository`                        | You're logged into the wrong account or invite not accepted. Run `gh auth login -h github.com -w`, then verify with `gh repo view andyvandaric/opencode-config-suites-releases`                                                                                                                                                          |
| LSP not working                                                     | Run `bun run setup:profile:update`                                                                                                                                                                                                                                                                                                       |
| Profile change seems not applied                                    | Stop `opencode web` (`Ctrl+C`) and run it again with the same port as before                                                                                                                                                                                                                                                             |
| `Script fails on Windows` / `Unexpected token '??'`                 | You're running Windows PowerShell 5.1. Run installer with `pwsh` (PowerShell 7). See section below.                                                                                                                                                                                                                                      |
| `winget: not found` on Windows                                      | You're on a stripped/debloated Windows (e.g. Ghost Spectre). The installer handles this automatically — or download tools manually from [git-scm.com](https://git-scm.com/download/win) and [cli.github.com/releases](https://github.com/cli/cli/releases/latest)                                                                        |
| `Error: Unable to connect. Is the computer able to access the url?` | OpenCode server is not running, port changed, or old node process still holds the port. Run `opencode web --port 8089` (same port as before), refresh browser, and if port remains blocked on Windows run `taskkill /IM node.exe /F` then retry. If needed, switch to another port (e.g. `--port 8090`)                                  |
| `Skill "skill_mcp" not found`                                       | The `ccs` tool is not installed. Run: `npm install -g @kaitranntt/ccs` (or via pnpm/bun), then restart OpenCode                                                                                                                                                                                                                          |
| CocoIndex state unclear                                             | Run `ocs index status` to verify the `ccc mcp` MCP server is registered and healthy before touching data.                                                                                                                                                                                                                                |
| Need to watch CocoIndex output                                      | Run `ocs index logs --tail 200 --follow` to stream the long-running `ccc mcp` STDIO. Keep the shell open while logs arrive.                                                                                                                                                                                                              |
| CocoIndex runtime still failing                                     | Run `ocs index doctor` to exercise the runtime-aware health checks and remediation hooks.                                                                                                                                                                                                                                                |
| Must rebuild CocoIndex data                                         | Run `ocs index rebuild --force`. Add `--hard-reset` only when you plan to delete every `.mdb` file and start from scratch (last resort).                                                                                                                                                                                                 |

---

### Windows path/environment divergence triage

Setups with missing, empty, or policy-locked `USERPROFILE`/`HOME` values now trigger a hybrid path guard that tries exactly one safe fallback (the Windows `UserProfile` special folder) before failing fast. Instead of crashing with `Cannot bind argument to parameter 'Path' because it is an empty string`, the installer exits with the structured marker `[OCS_INSTALLER_PATH_RESOLUTION_FAILED]`, writes a diagnostic JSON payload, and prints the same action plan every time.

1. **Inspect the env vars** — run `pwsh -NoProfile -Command "Write-Output USERPROFILE=$env:USERPROFILE; Write-Output HOME=$env:HOME"` or `Get-ChildItem env:USERPROFILE`, `Get-ChildItem env:HOME`. Empty, whitespace-only, or absent values trigger the guard, so confirm both entries resolve to real folders.
2. **Validate the fallback** — the guard falls back to the `UserProfile` special folder (the same base used for `~/.config/opencode` and `.opencode-suites`). Run `pwsh -NoProfile -Command "$fb = [Environment]::GetFolderPath('UserProfile'); Write-Output "Fallback=$fb"; Test-Path $fb"` and make sure the folder exists, is writable, and is not rooted inside `C:\Windows`, `System32`, or PolicyDefinitions/GroupPolicy. Wildcards such as `*`/`?` or policy-managed directories are rejected before any writes happen.
3. **Apply a replacement path if needed** — the diagnostic message already tells you to rerun the installer with an `OCS_USER_HOME` override if the normal profile path is unavailable. Point that override at a known writable folder that matches the hybrid fallback expectations (for example, `C:\Users\SafeAccount`) and rerun the installer.
4. **Capture the diagnostic file** — the error output also prints a `diagnosticFilePath` inside `%TEMP%/ocs-install-<runId>/diagnostics/path-resolution-<runId>.log`. Attach that file to your support ticket; it contains the JSON payload with `reasonCode`, `shortReason`, `primaryPath`, `fallbackPath`, `host`, `psVersion`, `runId`, and `diagnosticFilePath` itself.

#### Reason codes you will see

| Code | Meaning |
| ---- | ------- |
| `E_HOME_EMPTY` | The env vars resolved to empty or missing strings while the fallback exists. |
| `E_HOME_UNRESOLVED` | Neither the env vars nor the single fallback produced a valid path. |
| `E_HOME_NOT_WRITABLE` | The resolved path sits inside a system area that the current user cannot write to. |
| `E_FALLBACK_INVALID` | The candidate path contains wildcard/unsafe characters or otherwise fails the safety guard. |
| `E_POLICY_BLOCKED` | The folder is governed by Windows policy (PolicyDefinitions/GroupPolicy) and is explicitly blocked. |

Every failure emits `[OCS_INSTALLER_PATH_RESOLUTION_FAILED]` and the deterministic action checklist (verify `USERPROFILE`/`HOME`, ensure fallback is writable, rerun with `OCS_USER_HOME`, attach the diagnostic file). This guarantees no downstream writes (token cache, Bun shim, plugins) see an empty or unsafe path.

If you still cannot resolve the profile path after these steps, collect the `diagnosticFilePath` printed in the error line and send it to support together with the reason code that appeared on-screen; that log is the source of truth for the diagnostics contract and accelerates triage.

### Windows: install/verify PowerShell 7 (important)

The online installer uses PowerShell 7 syntax. If you run it in `powershell.exe` (Windows PowerShell 5.1), you may get parser errors like `Unexpected token '??'`.

Use this command for Windows install:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex"
```

Verify PowerShell 7 is available:

```powershell
pwsh --version
pwsh -NoProfile -Command "$PSVersionTable.PSVersion"
```

Install PowerShell 7 on Windows (choose one):

- `winget install --id Microsoft.PowerShell --source winget`
- Microsoft Store: search for **PowerShell** (Publisher: Microsoft)
- MSI installer: https://github.com/PowerShell/PowerShell/releases/latest

If your terminal still opens Windows PowerShell 5.1 by default, run with full `pwsh` path:

```powershell
& "$env:ProgramFiles\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex"
```

---

> For the full configuration reference, see the [Configuration section](../README.md#-configuration) in the README.
