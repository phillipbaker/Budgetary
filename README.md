# Budgetary

![Platform](https://img.shields.io/badge/platform-iOS-blue)
![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-blue)

An envelope budgeting app for iOS, built with SwiftUI. Money in your budget is assigned to categories and the amount remaining updates as you record transactions.

## Status

**Budgetary is a work in progress and isn’t ready for day-to-day use.** It’s a portfolio project. So far the work has gone into the architecture and core budgeting flow, not a complete feature set.

## Working Now

- **Envelope budgeting** — Assign money to categories by group with a custom number pad that can add and subtract. The amount left to assign updates as you go.
- **Monthly navigation** — Jump to a specific month with a custom month picker. Swipe the budget screen left or right to move backwards and forwards a month at a time. Tap a *Today* button to jump back to the current month.
- **Accounts** — Add bank and credit card accounts with a starting balance, and view each account’s transactions grouped by date.
- **Transactions** — Record transactions with a payee, category, account, date, memo and cleared status. Search payees and categories with ranked matching. Create new payees, categories and category groups inline without leaving the transaction.
- **Transfers** — Create transactions that transfer money from one account to another account. A paired transaction is automatically added to the other account.
- **Credit cards** — When created, credit card accounts get a credit card payment row in the budget that tracks spending and payments. Assign money directly to credit cards to pay down balances or cover otherwise unfunded credit spending.

## Not Yet Built

- Reassigning money directly from one category to another.
- Importing transactions. They can only be added one at a time.
- A special inflow category that adds to the total available to budget.
- Editing or deleting transactions, payees and categories. Editing, closing or deleting accounts.
- Persistence via SwiftData. The app currently uses preview data held in-memory for development.

## Architecture

Budgetary started with Clean Architecture, comprising per-feature layers for framework (views, data gateways, DAOs), presentation (view models), application (entities and use cases) and data (data sources). It’s partway through a migration to a Redux- or TCA-style architecture with a single, central store, written from scratch without a framework. Both designs are visible in the code right now.

### Target

```
View (action) → AppStore → reducer (state, action) → new state + effects (data)
     ↑                                                            ↓             
   state     ←     success/failure action     ←    effect runner calls repository
                                                                  ↓
                                                         Repository protocol
                                                                  ↓
                                                              Repository
                                                                  ↓
                                                              SwiftData                                        
```

- One store owns app state and navigation. Views read state and send actions to the store.
- State holds domain entities that refer to each other by ID, not by nested copies, so edits change one value.
- The monthly budget is computed from state, not stored.
- The reducer is pure. It receives state and action and returns new state and any effects, as values describing the work.
- Domain rules are pure functions on domain types and the reducer calls them directly.
- The reducer applies changes to entities in state and an effect saves them. The budget screen updates immediately.
- Repositories sit behind protocols, keeping the dependency inversion from the current architecture.
- Dependencies are injected into `EffectRunner`, which the store holds. The runner executes each effect and returns the resulting action.
- Data is mapped twice. On the data side, repositories map in both directions between SwiftData models and domain types. On the presentation side, pure selector functions derive presentation models from state.

### Current State

```
View (action) ←→ View Model → AppStore → reducer (state, action) → new state + effects (data)
                      ↑                                                        ↓
                    state     ←     success/failure action     ←  effect runner calls use case
                                                                               ↓   
                                                                            use case
                                                                               ↓   
                                                                     data source protocol
                                                                               ↓   
                                                                          data source
                                                                               ↓   
                                                                     data gateway protocol
                                                                               ↓
                                                                          data gateway
                                                                               ↓
                                                                              DAO
                                                                               ↓
                                                                        SwiftData (stub)
```

- An app store and reducer are in place. User actions, like assigning money to a category, currently pass through both architectures. Views send actions to view models, which forward them to the store. View models observe the store through an `AsyncStream` and map state to presentation models for the views.
- The store holds `BudgetData`, a computed read model, not the entities it’s computed from. Building the budget means loading from every data source, and every write reloads the whole budget.
- Transactions hold nested copies of their account, category and payee, not IDs.
- The reducer is a pure function returning `AppEffect` values. `EffectRunner` holds the use cases, runs each effect and returns a follow-up action for the store to dispatch.
- Domain logic lives in use cases. Data access goes through data sources, data gateways and DAOs, with protocols inverting the dependencies between use cases and data sources, and between data sources and gateways. Data is mapped immutably across boundaries from Db ←→ Plain ←→ Domain → Budget read model → Presentation models.
- Navigation is split. The store owns the selected tab and top-level sheet (new transaction or add account). Everything below that stays out of the store. Account detail is pushed with a `NavigationLink`. View models hold optional `Destination` enums for the month picker popover and the transaction form’s pickers. These are presented by the SwiftUINavigation framework.

### Dependencies

- Dependency injection with [Factory](https://github.com/hmlongco/Factory)
- Navigation and alerts with [SwiftUINavigation](https://github.com/pointfreeco/swift-navigation)

## Requirements

- Swift 6
- iOS 26.0+
- Xcode 26+

## Getting Started

1. Clone the repository:
   ```sh
   git clone https://github.com/phillipbaker/Budgetary.git
   cd Budgetary
   ```

2. Open the project in Xcode:
   ```sh
   open Budgetary.xcodeproj
   ```

3. Select the **Budgetary** scheme and run on a simulator or device.

Dependencies are resolved by Swift Package Manager — no manual setup required. There are no API keys. The app currently contains sample data for development.

## Testing

Tests cover the number pad’s calculator, the currency text field’s formatting and input handling, and the transaction amount view model.

Run the test suite from the command line:

```sh
xcodebuild test \
  -project Budgetary.xcodeproj \
  -scheme Budgetary \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

Or run the tests in Xcode with <kbd>⌘</kbd>+<kbd>U</kbd>.

## License

© 2026 Phillip Baker. All rights reserved.