# Dictionary API Reference

Complete API documentation for the NYC Building Trade Dictionary components.

## Types

### GlossaryTerm

```typescript
interface GlossaryTerm {
  id: string;              // Unique identifier (slug)
  term: string;            // Display name
  definition: string;      // Full definition text
  category: TermCategory;  // Category classification
  source: 'iqarius' | 'game';
  needs_review: boolean;   // True if needs human verification
  aliases: string[];       // Alternative names/spellings
  related_terms: string[]; // IDs of related terms
  image_url?: string;      // Optional image URL
}
```

### TermCategory

```typescript
type TermCategory =
  | 'Agencies'
  | 'Construction'
  | 'Documents'
  | 'Finance'
  | 'Legal'
  | 'Processes'
  | 'Professionals';
```

### DictionaryState

```typescript
interface DictionaryState {
  terms: GlossaryTerm[];
  isLoading: boolean;
  error: string | null;
  selectedTermId: string | null;
}
```

---

## Components

### DictionaryProvider

Context provider that manages dictionary state and data loading.

```tsx
import { DictionaryProvider } from '@unravel/dictionary';

<DictionaryProvider>
  {children}
</DictionaryProvider>
```

**Props:** None (wraps children)

**Provides:**
- Dictionary data loading
- State management
- Panel visibility control

---

### DictionaryPanel

Side panel component displaying term details.

```tsx
import { DictionaryPanel } from '@unravel/dictionary';

<DictionaryPanel
  isOpen={boolean}
  onClose={() => void}
  initialTermId?: string
/>
```

**Props:**

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| `isOpen` | `boolean` | Yes | Controls panel visibility |
| `onClose` | `() => void` | Yes | Called when panel should close |
| `initialTermId` | `string` | No | Term to display when panel opens |

**Behavior:**
- Slides in from right side
- 400px width (full width on mobile)
- Closes on ESC key or backdrop click
- Shows search, categories, term list, and detail view

---

### TextWithTerms

Wraps text and makes glossary terms clickable.

```tsx
import { TextWithTerms } from '@unravel/dictionary';

<TextWithTerms
  text={string}
  onTermClick={(term: GlossaryTerm) => void}
  className?: string
/>
```

**Props:**

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| `text` | `string` | Yes | Text to scan for terms |
| `onTermClick` | `(term: GlossaryTerm) => void` | Yes | Called when term clicked |
| `className` | `string` | No | Additional CSS class |

**Behavior:**
- Scans text for known glossary terms
- Wraps matches in clickable `<span>` elements
- Case-insensitive matching
- Matches whole words only (not partials)
- Recognizes aliases

**Styling:**
```css
.dictionary-term {
  color: #007bff;
  text-decoration: underline dotted;
  cursor: help;
}
.dictionary-term:hover {
  background-color: rgba(0, 123, 255, 0.1);
}
```

---

## Hooks

### useDictionaryPanel

Controls the dictionary panel visibility and selection.

```tsx
import { useDictionaryPanel } from '@unravel/dictionary';

const {
  isOpen,
  selectedTerm,
  openPanel,
  closePanel,
  openWithTerm,
  togglePanel
} = useDictionaryPanel();
```

**Returns:**

| Property | Type | Description |
|----------|------|-------------|
| `isOpen` | `boolean` | Panel visibility state |
| `selectedTerm` | `GlossaryTerm \| null` | Currently selected term |
| `openPanel` | `() => void` | Opens panel (no term selected) |
| `closePanel` | `() => void` | Closes panel |
| `openWithTerm` | `(termId: string) => void` | Opens panel to specific term |
| `togglePanel` | `() => void` | Toggles panel open/closed |

**Example:**
```tsx
function HelpButton({ termId }: { termId: string }) {
  const { openWithTerm } = useDictionaryPanel();

  return (
    <button onClick={() => openWithTerm(termId)}>
      <span>?</span>
    </button>
  );
}
```

---

### useDictionary

Access dictionary data and search functions.

```tsx
import { useDictionary } from '@unravel/dictionary';

const {
  terms,
  isLoading,
  error,
  getTermById,
  getTermByWord,
  searchTerms,
  getTermsByCategory,
  getRelatedTerms,
  getAllCategories
} = useDictionary();
```

**Returns:**

| Property | Type | Description |
|----------|------|-------------|
| `terms` | `GlossaryTerm[]` | All loaded terms |
| `isLoading` | `boolean` | True while loading CSV |
| `error` | `string \| null` | Error message if load failed |
| `getTermById` | `(id: string) => GlossaryTerm \| undefined` | Find term by ID |
| `getTermByWord` | `(word: string) => GlossaryTerm \| undefined` | Find by term/alias |
| `searchTerms` | `(query: string) => GlossaryTerm[]` | Search terms |
| `getTermsByCategory` | `(category: string) => GlossaryTerm[]` | Filter by category |
| `getRelatedTerms` | `(termId: string) => GlossaryTerm[]` | Get related terms |
| `getAllCategories` | `() => string[]` | List all categories |

---

## Data Functions

### loadTerms

Loads and parses the GLOSSARY.csv file.

```typescript
import { loadTerms } from '@unravel/dictionary';

const terms: GlossaryTerm[] = await loadTerms();
```

**Returns:** `Promise<GlossaryTerm[]>`

**Throws:** Error if CSV cannot be loaded or parsed

---

### getTermById

Finds a term by its unique ID.

```typescript
import { getTermById } from '@unravel/dictionary';

const term = getTermById(terms, 'certificate-of-occupancy');
// Returns: GlossaryTerm | undefined
```

---

### findTermByWord

Finds a term by its display name or any alias.

```typescript
import { findTermByWord } from '@unravel/dictionary';

const term = findTermByWord(terms, 'CO');
// Returns: GlossaryTerm | undefined (finds Certificate of Occupancy)
```

**Matching rules:**
- Case-insensitive
- Matches term name or any alias
- Exact match only (no partial)

---

### searchTerms

Searches terms by query string.

```typescript
import { searchTerms } from '@unravel/dictionary';

const results = searchTerms(terms, 'permit');
// Returns: GlossaryTerm[] (all terms containing "permit")
```

**Searches:**
- Term name
- Definition
- Aliases

---

## CSS Classes

### Panel Classes

| Class | Description |
|-------|-------------|
| `.dictionary-panel` | Main panel container |
| `.dictionary-panel-overlay` | Backdrop overlay |
| `.dictionary-panel-header` | Panel header with title |
| `.dictionary-panel-search` | Search input container |
| `.dictionary-panel-categories` | Category filter buttons |
| `.dictionary-panel-list` | Term list container |
| `.dictionary-panel-detail` | Term detail view |

### Term Classes

| Class | Description |
|-------|-------------|
| `.dictionary-term` | Clickable term in text |
| `.dictionary-term-card` | Term card in list |
| `.dictionary-term-title` | Term display name |
| `.dictionary-term-definition` | Definition text |
| `.dictionary-term-category` | Category badge |
| `.dictionary-term-image` | Term image |
| `.dictionary-term-related` | Related terms section |

### State Classes

| Class | Description |
|-------|-------------|
| `.dictionary-panel--open` | Panel is visible |
| `.dictionary-term--active` | Currently selected term |
| `.dictionary-term--needs-review` | Term needs review |

---

## Events

### Panel Events

The panel emits no custom events. Use the hook callbacks:

```tsx
const { openWithTerm, closePanel } = useDictionaryPanel();

// Open to term
openWithTerm('permit');

// Close
closePanel();
```

### Term Click Events

Handle via `onTermClick` prop:

```tsx
<TextWithTerms
  text="..."
  onTermClick={(term) => {
    console.log('Clicked:', term.id);
    // term is full GlossaryTerm object
  }}
/>
```

---

## Error Handling

### Loading Errors

```tsx
const { error, isLoading } = useDictionary();

if (error) {
  return <div>Failed to load dictionary: {error}</div>;
}

if (isLoading) {
  return <div>Loading...</div>;
}
```

### Missing Terms

```tsx
const { getTermById } = useDictionary();

const term = getTermById('unknown-id');
if (!term) {
  console.warn('Term not found');
}
```

---

## Constants

### CSV Path

Default: `/data/GLOSSARY.csv`

Override in `src/data/terms.ts`:

```typescript
const CSV_PATH = '/custom/path/GLOSSARY.csv';
```

### Panel Width

Default: `400px`

Override in CSS:

```css
.dictionary-panel {
  width: 500px;
}
```

### Mobile Breakpoint

Default: `768px`

Override in CSS:

```css
@media (max-width: 600px) {
  .dictionary-panel {
    width: 100%;
  }
}
```
