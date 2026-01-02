# Dictionary Terms Guide

This document describes the term categories, sources, and how to add or edit terms.

## Term Statistics

| Metric | Count |
|--------|-------|
| **Total terms** | 95 |
| **From iqarius.com** | 63 (verified definitions) |
| **From game** | 32 (AI-drafted, needs review) |
| **With images** | 15 |
| **Categories** | 7 |

## Categories

### Agencies (14 terms)
Government agencies and regulatory bodies.

| Term | Description |
|------|-------------|
| ACRIS | Automated City Register Information System |
| BIS | Buildings Information System |
| DEP | Department of Environmental Protection |
| DOB | Department of Buildings |
| DOB NOW | DOB's online system |
| DOT | Department of Transportation |
| ECB | Environmental Control Board |
| EPA | Environmental Protection Agency |
| FDNY | Fire Department of New York |
| HPD | Housing Preservation and Development |
| NYCHA | NYC Housing Authority |
| OATH | Office of Administrative Trials and Hearings |
| REBNY | Real Estate Board of New York |

### Construction (18 terms)
Building materials, methods, and physical elements.

| Term | Description |
|------|-------------|
| Alteration | Changes requiring new CO |
| Apartment Building | 4+ dwelling units |
| Asbestos | Hazardous building material |
| Attic Renovation | Converting attic to living space |
| Basement | Below-ground floor level |
| Facade | Exterior building face |
| Fixer-Upper | Property needing renovation |
| Foundation | Building structural base |
| Gas Meter | Natural gas metering equipment |
| Green Building | Sustainable construction |
| HVAC | Heating, ventilation, AC systems |
| Joist | Horizontal structural member |
| Kitchen | Cooking space (80+ sq ft) |
| Mechanical Systems | Non-structural building systems |
| Mold | Fungal growth in buildings |
| Plumbing | Water supply/drainage systems |
| Renovation | Property improvements |
| Scaffolding | Temporary work platforms |

### Documents (10 terms)
Permits, certificates, and official paperwork.

| Term | Description |
|------|-------------|
| Certificate | Various DOB certificate types |
| Certificate of Correction | Confirms violation is fixed |
| Certificate of Occupancy | Building compliance document |
| Demolition Permit | Authorization to tear down |
| LAA | Limited Alteration Application |
| LOC | Letter of Completion |
| Notice of Violation | Official violation notice |
| Permit | Work authorization |
| PW1 | Plan/Work Application |
| SWO | Stop Work Order |

### Finance (6 terms)
Loans, funding, and financial concepts.

| Term | Description |
|------|-------------|
| Bank | Construction loan provider |
| Change Order | Contract modification |
| Investor | Project capital provider |
| Loan | Construction financing |
| Underwriting | Loan risk evaluation |

### Legal (18 terms)
Violations, codes, regulations, and legal matters.

| Term | Description |
|------|-------------|
| Advertising Sign | Commercial signage rules |
| Class of Violation | Violation severity categories |
| Directive 14 | DOB enforcement mechanism |
| Failure to Comply | Not correcting violations |
| Fire Code Violation | FDNY non-compliance |
| Illegal Conversion | Unpermitted use change |
| Incident | Construction-caused occurrence |
| MDL | Multiple Dwelling Law |
| Penalty | Violation fines |
| Plumbing Violations | Plumbing code failures |
| Property | Real estate records |
| Residential | Building use classification |
| Unpermitted | Work without authorization |
| Unsafe Building | Dangerous structure |
| Variance | Zoning exception |
| Violation | Agency non-compliance notice |
| W/O Permit | Work without permit violation |
| Zoning | Land use regulations |

### Processes (10 terms)
Filing, inspection, and review procedures.

| Term | Description |
|------|-------------|
| After Hours Work | Work outside normal hours |
| Audit | DOB document review |
| Complaint | Report of code issues |
| eFiling | Online permit submission |
| Filing | Document submission to DOB |
| Final Review | Last approval stage |
| FISP | Facade Inspection Safety Program |
| Inspection | Official work examination |
| Plan Exam | DOB plan review |
| Professional Certification | Prof Cert approval path |

### Professionals (11 terms)
People and roles in construction.

| Term | Description |
|------|-------------|
| Applicant of Record | Licensed filing professional |
| Architect | Building designer |
| Clerk | DOB administrative staff |
| Contractor | Construction professional |
| Engineer | Systems designer |
| Expeditor | Filing representative |
| Inspector | Code enforcement official |
| LMP | Licensed Master Plumber |
| Owner | Property owner |
| Plan Examiner | DOB reviewer |
| Project Manager | Construction coordinator |
| QEWI | Qualified Exterior Wall Inspector |

## Data Sources

### iqarius.com (63 terms)
Definitions from the [NYC DOB Violation Glossary](https://iqarius.com/encyclopedia/) on iqarius.com. These are verified, accurate definitions written by industry professionals.

### Game (32 terms)
AI-generated definitions marked with `[AI-DRAFT]` prefix. These need human review before being considered authoritative. They were created to fill gaps for game-specific concepts not covered by iqarius.com.

## Adding New Terms

### Using the Editor

1. Open `tools/glossary-editor.html` in a browser
2. Load `data/GLOSSARY.csv`
3. Click "+ Add Term"
4. Fill in all required fields
5. Download the updated CSV

### Required Fields

| Field | Rules |
|-------|-------|
| **ID** | Lowercase, hyphens for spaces (e.g., `certificate-of-occupancy`) |
| **Term** | Display name with proper capitalization |
| **Definition** | Clear, concise explanation |
| **Category** | One of the 7 categories above |
| **Source** | `iqarius` or `game` |

### Optional Fields

| Field | Format |
|-------|--------|
| **Aliases** | Pipe-separated: `CO|C of O` |
| **Related Terms** | Pipe-separated IDs: `permit|inspection` |
| **Image URL** | Full URL to image |
| **Needs Review** | `true` if definition needs verification |

## Writing Good Definitions

### Do
- Start with what the term IS
- Keep it under 200 words
- Include NYC-specific context
- Mention related agencies or processes
- Use plain language

### Don't
- Start with "A [term] is..."
- Use jargon without explanation
- Copy verbatim from other sources
- Include time-sensitive information
- Add promotional content

### Examples

**Good:**
> Certificate of Occupancy (CO) - Official document confirming a building is safe to occupy and complies with all applicable codes. Required before a building can be legally used.

**Bad:**
> A CO is what you need to get before moving in. Call us for help!

## Images

### Current Images (15)

From iqarius.com:
- ACRIS, Apartment Building, Asbestos, Certificate of Occupancy
- DEP, DOB, DOB NOW, DOT, ECB
- Expeditor, Foundation, Inspector, MDL
- Permit, Property, Violation

### Adding Images

1. Use images from iqarius.com when available
2. Host on a reliable CDN
3. Recommended size: 350x260px
4. Use JPG or PNG format
5. Include alt text in the term definition

### Image Sources Priority

1. iqarius.com (preferred - already licensed)
2. NYC.gov official images
3. Public domain / Creative Commons
4. Original photography (with permission)

## Review Process

Terms marked `needs_review: true` should be:

1. Verified against official NYC DOB resources
2. Compared with iqarius.com definitions
3. Checked for accuracy and completeness
4. Updated to remove `[AI-DRAFT]` prefix
5. Changed to `needs_review: false`

## Maintenance

### Regular Updates

- Check iqarius.com for new encyclopedia entries
- Review game-sourced terms for accuracy
- Update definitions for regulatory changes
- Fix broken image links

### Version Control

The GLOSSARY.csv is tracked in git. Always:
1. Make changes using the editor
2. Test the changes locally
3. Commit with descriptive message
4. Note changes in commit message
