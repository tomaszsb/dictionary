# NYC Building Trade Dictionary

A standalone, reusable React component library for displaying NYC building trade terminology. Used by [Unravel Codes: The Game](https://unravel-game.duckdns.org:3080) and [iqarius.com](https://iqarius.com).

## Features

- **95 building trade terms** with definitions from iqarius.com encyclopedia
- **Side panel UI** that slides in from the right
- **Clickable term detection** - automatically highlights glossary terms in any text
- **Search and filter** by category
- **Image support** - terms can include images
- **Related terms** - navigate between connected concepts
- **Standalone design** - no external dependencies beyond React

## Quick Start

### Installation

Copy the `src/` folder into your React project, or install as a local dependency:

```bash
# From your project root
npm install ../dictionary
```

### Basic Usage

```tsx
import { DictionaryProvider, DictionaryPanel, TextWithTerms, useDictionaryPanel } from '@unravel/dictionary';

function App() {
  return (
    <DictionaryProvider>
      <YourContent />
      <DictionaryPanelWrapper />
    </DictionaryProvider>
  );
}

function YourContent() {
  const { openWithTerm } = useDictionaryPanel();

  return (
    <div>
      {/* Text with clickable glossary terms */}
      <TextWithTerms
        text="The DOB inspector found a violation during the permit review."
        onTermClick={(term) => openWithTerm(term.id)}
      />
    </div>
  );
}

function DictionaryPanelWrapper() {
  const { isOpen, closePanel, selectedTerm } = useDictionaryPanel();
  return (
    <DictionaryPanel
      isOpen={isOpen}
      onClose={closePanel}
      initialTermId={selectedTerm?.id}
    />
  );
}
```

## Components

### `<DictionaryProvider>`

Context provider that manages dictionary state. Wrap your app with this.

### `<DictionaryPanel>`

The main side panel component that displays terms.

| Prop | Type | Description |
|------|------|-------------|
| `isOpen` | `boolean` | Whether the panel is visible |
| `onClose` | `() => void` | Called when panel should close |
| `initialTermId` | `string?` | Term to show when panel opens |

### `<TextWithTerms>`

Wraps text and makes glossary terms clickable.

| Prop | Type | Description |
|------|------|-------------|
| `text` | `string` | The text to scan for terms |
| `onTermClick` | `(term) => void` | Called when a term is clicked |

### `useDictionaryPanel()`

Hook for controlling the panel.

```tsx
const {
  isOpen,           // boolean - panel visibility
  openPanel,        // () => void - open panel
  closePanel,       // () => void - close panel
  openWithTerm,     // (termId: string) => void - open to specific term
  selectedTerm      // GlossaryTerm | null - currently selected term
} = useDictionaryPanel();
```

## Data Structure

Terms are stored in `data/GLOSSARY.csv` with these fields:

| Field | Description |
|-------|-------------|
| `id` | Unique slug (e.g., `certificate-of-occupancy`) |
| `term` | Display name (e.g., `Certificate of Occupancy`) |
| `definition` | Full definition text |
| `category` | One of: Agencies, Construction, Documents, Finance, Legal, Processes, Professionals |
| `source` | `iqarius` (verified) or `game` (AI-drafted) |
| `needs_review` | `true` if definition needs human review |
| `aliases` | Pipe-separated alternative names (e.g., `CO|C of O`) |
| `related_terms` | Pipe-separated related term IDs |
| `image_url` | Optional image URL |

## Editing Terms

Use the standalone editor:

1. Open `tools/glossary-editor.html` in a browser
2. Load `data/GLOSSARY.csv`
3. Edit, add, or delete terms
4. Download the updated CSV
5. Replace `data/GLOSSARY.csv`

## File Structure

```
dictionary/
├── src/
│   ├── components/
│   │   ├── DictionaryPanel.tsx    # Main side panel
│   │   ├── DictionaryPanel.css    # Styles
│   │   └── TextWithTerms.tsx      # Clickable text wrapper
│   ├── context/
│   │   └── DictionaryContext.tsx  # React context
│   ├── data/
│   │   └── terms.ts               # CSV loading utilities
│   ├── hooks/
│   │   └── useDictionary.ts       # Dictionary hook
│   ├── types/
│   │   └── index.ts               # TypeScript interfaces
│   └── index.ts                   # Public exports
├── data/
│   └── GLOSSARY.csv               # Term database (95 terms)
├── tools/
│   └── glossary-editor.html       # Standalone CSV editor
├── docs/
│   ├── INTEGRATION.md             # Integration guide
│   ├── TERMS_GUIDE.md             # Term categories and sources
│   └── API.md                     # Full API reference
├── package.json
└── README.md
```

## Integration with iqarius.com

The dictionary is designed to work standalone on iqarius.com:

1. Copy `src/` and `data/` folders to your project
2. Import components as shown above
3. Customize styling via CSS variables in `DictionaryPanel.css`

## Term Statistics

| Metric | Count |
|--------|-------|
| Total terms | 95 |
| From iqarius.com | 63 |
| From game (AI-draft) | 32 |
| With images | 15 |
| Categories | 7 |

## Categories

- **Agencies** - DOB, DEP, HPD, FDNY, ECB, etc.
- **Construction** - Materials, methods, building elements
- **Documents** - Permits, certificates, applications
- **Finance** - Loans, funding, costs
- **Legal** - Violations, codes, regulations
- **Processes** - Filing, inspection, review procedures
- **Professionals** - Architects, engineers, contractors, expeditors

## License

MIT License - Free to use in personal and commercial projects.

## Contributing

1. Edit terms using `tools/glossary-editor.html`
2. Ensure definitions are accurate and sourced
3. Mark AI-generated content with `[AI-DRAFT]` prefix
4. Submit updates via pull request

## Credits

- Term definitions from [iqarius.com](https://iqarius.com) NYC DOB Violation Glossary
- Built for [Unravel Codes: The Game](https://unravel-game.duckdns.org:3080)
