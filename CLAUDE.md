# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

LightningUiKit is a Ruby gem that provides UI components for Rails applications. It's built on top of ViewComponent and uses Tailwind CSS for styling with Stimulus controllers for interactive behavior.

## Architecture

- **Component System**: Based on ViewComponent with a base class `LightningUiKit::BaseComponent` that includes TailwindMerge for CSS class management and HeroiconHelper for icons
- **Frontend Assets**: Uses esbuild for JavaScript bundling and Tailwind CSS for styling
- **Rails Engine**: Packaged as a Rails engine with isolated namespace `LightningUiKit`
- **Development Environment**: Includes Lookbook for component previews and documentation

### Key Directories

- `app/components/lightning_ui_kit/` - ViewComponent classes and templates
- `app/javascript/lightning_ui_kit/controllers/` - Stimulus controllers
- `app/assets/stylesheets/` - Tailwind CSS entry point
- `lib/lightning_ui_kit/` - Gem configuration and Rails engine
- `lookbook/` - Standalone Rails app for component previews

## Common Development Commands

### Setup
```bash
make install          # Install Ruby and npm dependencies
```

### Development
```bash
make start            # Start development server with asset watching
make docs             # Start Lookbook component preview server
```

### Asset Building
```bash
npm run dev:build:css   # Watch and build Tailwind CSS
npm run dev:build:js    # Build JavaScript with esbuild
make build             # Build production assets
```

### Testing and Code Quality
```bash
make test             # Run RSpec tests
make lint-fix         # Fix Ruby style issues with StandardRB
bundle exec rspec     # Run specific tests
```

### Release Process
```bash
make release [version]  # Build assets, commit, tag, and release gem
```

## Component Development

### Component Structure
- Each component extends `LightningUiKit::BaseComponent`
- Templates use `.html.erb` extension
- Interactive components include corresponding Stimulus controllers
- Preview files in `lookbook/app/previews/` for documentation

### Styling Conventions
- Uses Tailwind CSS classes exclusively
- **CRITICAL**: Always prefix Tailwind classes with `lui:` (e.g., `lui:px-4`, `lui:text-blue-600`, `lui:underline`)
- TailwindMerge handles class conflicts and duplicates via `merge_classes()` helper
- Dark mode is disabled in configuration

### JavaScript Architecture
- Stimulus controllers in `app/javascript/lightning_ui_kit/controllers/`
- Uses Floating UI library for positioning (tooltips, dropdowns)
- Entry point: `app/javascript/lightning_ui_kit/index.js`

### Documentation Maintenance
- **IMPORTANT**: When adding or removing components/features, always update `llms.txt` to keep LLM documentation in sync
- **IMPORTANT**: Don't forget to update README.md and Lookbook previews for new components
- **IMPORTANT**: Dont't forget to update lookbook/test/components/docs/*.md files for project documentation

## Dependencies

### Core Dependencies
- Rails 8.0+
- ViewComponent
- TailwindMerge
- Heroicons

### Development Dependencies
- StandardRB for Ruby linting
- RSpec for testing
- Lookbook for component previews
- esbuild for JavaScript bundling
