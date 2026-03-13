# Feishu-Related GitHub Issue Replies

> ← [Back to README](../README.md) | [📚 Docs Index](./README.md)

Summary of 4 Feishu-related issues resolved through code changes.

---

## #55 Feishu doesn't support inter-bot communication

Confirmed: Feishu Bots cannot @-trigger each other (this is a Feishu platform limitation, not OpenClaw). Discord Bots can inter-trigger, but Feishu Bot @mentions are not recognized as events by other Bots.

**Solution**: Feishu now uses **single-bot (Chief of Staff) + sessions_spawn background dispatch** architecture.

---

## #52 How to have a single entry point

Feishu now defaults to single-bot mode. Run `install.sh`, choose Feishu mode — just 1 Feishu app (Chief of Staff), 1 set of App ID / App Secret.

The Chief of Staff automatically dispatches to 9 departments via `sessions_spawn`.

---

## #51 Does Feishu require a separate bot per Agent?

**No.** Feishu recommended mode: single bot.
- Only 1 Feishu app needed (Chief of Staff)
- All 10 Agents retained (working in background)
- Only 1 binding (Feishu → Chief of Staff)
- Other departments dispatched via `sessions_spawn`

---

## #22 Multi-Agent interaction without Discord

Feishu single-bot + sessions_spawn is the answer:
- **Platform**: Feishu (no VPN needed in China, WebSocket — no public IP required)
- **Architecture**: Single bot as entry point, sessions_spawn dispatches to 9 departments
- **Result**: Equivalent to Discord multi-bot mode, just different dispatch mechanism

Also supports pure WebUI mode (Path E) — no bot platform needed at all.
