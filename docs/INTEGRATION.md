# Dictionary Integration Guide

This guide explains how to integrate the NYC Building Trade Dictionary into your React application.

## Prerequisites

- React 18+
- TypeScript (recommended)

## Installation Options

### Option 1: Copy Files (Recommended for iqarius.com)

Copy the entire `src/` folder into your project:

```bash
cp -r dictionary/src/ your-project/src/dictionary/
cp dictionary/data/GLOSSARY.csv your-project/public/data/
```

### Option 2: Local Package

Add as a local dependency in your `package.json`:

```json
{
  "dependencies": {
    "@unravel/dictionary": "file:../dictionary"
  }
}
```

Then run `npm install`.

### Option 3: Symlink (Development)

Create a symlink for active development:

```bash
# In your project's src folder
ln -s ../../dictionary/src dictionary
```

## Basic Integration

### 1. Add the Provider

Wrap your app with `DictionaryProvider`:

```tsx
// App.tsx
import { DictionaryProvider } from './dictionary';

function App() {
  return (
    <DictionaryProvider>
      <YourApp />
    </DictionaryProvider>
  );
}
```

### 2. Add the Panel

Add `DictionaryPanel` somewhere in your component tree:

```tsx
import { DictionaryPanel, useDictionaryPanel } from './dictionary';

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

### 3. Make Text Clickable

Use `TextWithTerms` to automatically detect and highlight glossary terms:

```tsx
import { TextWithTerms, useDictionaryPanel } from './dictionary';

function MyComponent() {
  const { openWithTerm } = useDictionaryPanel();

  return (
    <p>
      <TextWithTerms
        text="Contact the DOB about your permit application."
        onTermClick={(term) => openWithTerm(term.id)}
      />
    </p>
  );
}
```

## Data File Location

The dictionary loads terms from `/data/GLOSSARY.csv` by default. Ensure this file is accessible:

```
your-project/
├── public/
│   └── data/
│       └── GLOSSARY.csv    # Place here for web serving
└── src/
    └── dictionary/         # Dictionary components
```

### Custom Data Path

If your CSV is in a different location, modify `src/dictionary/data/terms.ts`:

```typescript
const CSV_PATH = '/your/custom/path/GLOSSARY.csv';
```

## Styling

### CSS Variables

The dictionary uses CSS custom properties for theming. Override in your CSS:

```css
:root {
  --dictionary-bg: #ffffff;
  --dictionary-text: #2c3e50;
  --dictionary-border: #e0e0e0;
  --dictionary-accent: #3498db;
  --dictionary-term-highlight: rgba(52, 152, 219, 0.1);
}
```

### Panel Width

Default panel width is 400px. Customize in `DictionaryPanel.css`:

```css
.dictionary-panel {
  width: 450px;  /* Your preferred width */
}
```

### Mobile Responsive

The panel automatically goes full-width on mobile (< 768px). Adjust the breakpoint:

```css
@media (max-width: 600px) {
  .dictionary-panel {
    width: 100%;
  }
}
```

## Advanced Usage

### Programmatic Control

Open the dictionary to a specific term from anywhere:

```tsx
import { useDictionaryPanel } from './dictionary';

function HelpButton() {
  const { openWithTerm } = useDictionaryPanel();

  return (
    <button onClick={() => openWithTerm('permit')}>
      What's a permit?
    </button>
  );
}
```

### Search Integration

Access the search function directly:

```tsx
import { useDictionary } from './dictionary';

function SearchComponent() {
  const { searchTerms } = useDictionary();
  const [results, setResults] = useState([]);

  const handleSearch = (query) => {
    setResults(searchTerms(query));
  };

  return (
    <input
      type="text"
      placeholder="Search terms..."
      onChange={(e) => handleSearch(e.target.value)}
    />
  );
}
```

### Get Term by ID

```tsx
import { useDictionary } from './dictionary';

function TermDisplay({ termId }) {
  const { getTermById } = useDictionary();
  const term = getTermById(termId);

  if (!term) return <span>Unknown term</span>;

  return (
    <div>
      <h3>{term.term}</h3>
      <p>{term.definition}</p>
    </div>
  );
}
```

## Integration with Existing Modals

If you have existing modal systems, you can use just the data layer:

```tsx
import { useDictionary } from './dictionary';

function YourCustomModal({ termId, onClose }) {
  const { getTermById, getRelatedTerms } = useDictionary();
  const term = getTermById(termId);
  const related = getRelatedTerms(termId);

  return (
    <YourModalComponent onClose={onClose}>
      <h2>{term?.term}</h2>
      <p>{term?.definition}</p>
      {term?.image_url && <img src={term.image_url} alt={term.term} />}
      <h4>Related:</h4>
      <ul>
        {related.map(r => <li key={r.id}>{r.term}</li>)}
      </ul>
    </YourModalComponent>
  );
}
```

## Troubleshooting

### Terms not loading

1. Check browser console for fetch errors
2. Verify GLOSSARY.csv is in the correct location
3. Ensure the CSV is valid (no encoding issues)

### Terms not highlighting

1. Terms must match exactly (case-insensitive)
2. Check that aliases are defined for common variations
3. Partial matches are ignored (e.g., "permit" won't match "permitted")

### Panel not appearing

1. Ensure `DictionaryProvider` wraps your app
2. Check that `DictionaryPanel` is rendered
3. Verify `isOpen` state is being set correctly

## Performance

- Terms are loaded once and cached
- Text scanning uses optimized regex matching
- Panel renders lazily (only when open)

For large text blocks, consider debouncing the TextWithTerms component:

```tsx
import { useMemo } from 'react';

function OptimizedText({ text }) {
  const { openWithTerm } = useDictionaryPanel();

  const memoizedText = useMemo(() => (
    <TextWithTerms text={text} onTermClick={(t) => openWithTerm(t.id)} />
  ), [text]);

  return memoizedText;
}
```
