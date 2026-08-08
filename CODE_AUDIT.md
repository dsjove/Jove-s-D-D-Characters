# Character Model / Basic Sheet Audit

## Completed changes

- Separated structural `invariant()` validation from `Character.validateForPlay()` completeness validation.
- Restored the default-initializer contract: default `EmptyCheckable` model values are empty and structurally valid.
- Added stable `Character.id`, `CharacterSize`, and `CreatureType`.
- Made identity orientation and alignment meaningfully unset (`Optional`) rather than silently defaulting to concrete values.
- Added configurable spell-slot recharge (including short-rest Pact-style slots).
- Completed leaf-property volatility / presence annotations under `PROPERTY_VOLATILITY_LEGEND.txt` and documented the validation/emptiness contract.
- Corrected `currentxperience` to `currentExperience`.
- Corrected required fixtures and made `EmptyGuy` exactly `Character()`.
- Added exhaustive `JSONGuy` and `CharacterJSONExporter`.
- Corrected Big Guy contradictions and retained him as a broadly populated realistic/custom-content fixture.
- Revalidated Ash; kept Doug/Firestar as structurally valid partial characters and Quinn as play-ready.
- Expanded Basic Sheet rendering to expose stored attack, spell, equipment, appearance, associated-creature, and other model values.
- Added page-level and component-level empty-content checks; empty pages are omitted by `SheetRender`.
- Removed the standalone Encumbrance view; encumbrance remains summarized in the Equipment heading.
- Removed the compact Money summary; the full denomination table is the only Money presentation.
- Fixed feature source formatting, maneuver nil-DC rendering, and health labels.
- Removed the empty `Other` sheet.
- App cleanup: stable ID selection/persistence, no force-unwrapped registry defaults, one render trigger, generic export directory, JSON sharing, PDF observer Coordinator ownership, and an explicit empty-sheet state.

## Verification performed

- `swiftc -parse` succeeds for every Swift source file.
- Platform-independent model and fixture sources compile and execute under Swift 6.2.1 using a minimal display-protocol stub for UIKit-dependent presentation extensions.
- Structural invariants pass for Empty Guy, Big Guy, Ash, Doug, Quinn, Firestar, and JSON Guy.
- Play validation passes for Big Guy, Ash, Quinn, and JSON Guy; Empty Guy and the intentionally partial Doug/Firestar fail only completeness checks as expected.
- JSON Guy exports successfully and recursive schema coverage observes all 185 expected reachable JSON keys.
- `Equipment()`, `ResourceCounter()`, and `ReusableResource()` are empty by default; a named Equipment defaults to quantity 1; a maneuver-DC-only Capabilities value is nonempty.

## Environment limitation

The container is Linux and has no Xcode/UIKit/SBJLayout toolchain, so an actual iOS target build and visual PDF render cannot be run here. The complete source tree passes Swift syntax parsing, and the model layer receives semantic compilation/runtime validation as described above.
