# Draft: Nijuni 36 — dead WSX column (USB debug)

## Requirements (confirmed)
- Keyboard: **Nijuni 36**.
- Symptom: **the W/S/X column does not work** (user: “столбец wsx не работает”), despite continuity/"rings" checks in all directions.
- Connection: USB.
- Display: user removed/doesn’t use left display (“от экранчика на левой я отказался”).

## What I Found (repo evidence)
- `build.yaml` builds `board: nice_nano` + `shield: corne_left` + `snippet: zmk-usb-logging`.
- Only local overlays present are `config/boards/shields/corne_left.overlay` and `config/boards/shields/corne_right.overlay`, and they only disable `&spi1`/`&display` (no kscan/matrix pins defined there).
- No repository matches for: `kscan`, `row-gpios`, `col-gpios`, `diode-direction`, `gpio-matrix`, `transform` (outside upstream shield).
- Keymap uses `config/keys/36.h` which is only layout mapping macros (not hardware pins).

## Upstream Corne Mapping (important)
- Upstream ZMK Corne shield defines the matrix in:
  - `app/boards/shields/corne/corne.dtsi` (rows + diode-direction)
  - `app/boards/shields/corne/corne_left.overlay` (left columns)
  - `app/boards/shields/corne/corne_right.overlay` (right columns + col-offset)
- Upstream diode-direction: `col2row`.
- From upstream keymap ordering, **W/S/X are in left-half column index 2 (0-based)**.
- In upstream `corne_left.overlay`, **left column index 2 maps to `&pro_micro 19`**.

## Hypotheses to Validate
- **Pin mapping issue**: On `nice_nano` (nRF52840), `pro_micro 19` may map to **P0.09 or P0.10 (NFCT pins)**. If NFCT is enabled, those pins may not behave as GPIO → could cause exactly “one dead column”.
- **Shield mismatch**: Using `corne_left` shield for Nijuni 36 may be incorrect if Nijuni uses a different matrix wiring/pinout.
- **Keymap vs physical wiring**: If matrix is wired differently than the Corne shield expects, a specific physical column could be mis-assigned.

## Open Questions
- Does the issue affect only left-hand keys (W/S/X), or also any right-hand keys?
- Are any other keys dead (e.g., E/D/C or Q/A/Z), or is it strictly that one physical column?
- Which MCU/pins are used for the matrix on your Nijuni 36 build (if you have the schematic/pin list)?
- Are you flashing `nice_nano` or a different controller?
