# Overview

This project was structured using a modular architecture inspired by modern Roblox development patterns.

The main goals are:

- Clear Client and Server separation
- Low coupling
- High maintainability
- Code reusability
- Scalability
- Responsibility-based organization
- Automatic module initialization

The architecture was designed to allow new systems to be added quickly without creating excessive dependencies.

---

# Project Structure

```txt
ReplicatedStorage
 ├── Shared
 ├── Remotes
 ├── Packages
 └── Config

ServerScriptService
 ├── Services
 ├── Modules
 ├── Data
 └── Bootstrap

StarterPlayer
 └── StarterPlayerScripts
      ├── ClientModules
      ├── Controllers
      ├── Screens
      ├── Util
      └── Bootstrap
```

---

# Architecture Philosophy

The project follows a responsibility-based separation.

| Layer | Responsibility |
|---|---|
| Shared | Code shared between Client and Server |
| Services | Server-side business logic |
| Controllers | Client-side flow control |
| Screens | UI behavior and presentation |
| Util | Helpers, abstractions, and utilities |
| Remotes | Client ↔ Server communication |
| Data | Player data persistence |

---

# Initialization Flow

The project initialization is handled through a centralized bootstrap system.

## Client

The client automatically scans modules inside `ClientModules` and initializes any module containing:

```lua
module.Init()
```

This removes the need for manual initialization spread throughout the project.

Example:

```lua
for _, moduleScript in clientModules:GetChildren() do
	local module = require(moduleScript)

	if module.Init then
		module:Init()
	end
end
```

---

## Server

The server follows the same concept.

Services are automatically initialized during server boot:

```lua
PlayerService:Init()
InventoryService:Init()
IndexService:Init()
```

---

# Client ↔ Server Communication

Communication is centralized through a remote manager.

## Goals

- Avoid scattered RemoteEvents
- Standardize payloads
- Simplify debugging
- Improve maintainability
- Reduce duplication

---

## Usage Example

### Client

```lua
RemoteManager:FireServer("BuyItem", {
	itemId = 10
})
```

### Server

```lua
RemoteManager:ConnectEvent("BuyItem", function(player, data)
	ShopService:Buy(player, data.itemId)
end)
```

---

# UI System

The project uses modular screens.

Each screen contains:

- Its own module
- Its own logic
- Its own state
- Lifecycle methods

---

## Screen Structure

```lua
local InventoryScreen = {}

function InventoryScreen:Open(data)
end

function InventoryScreen:Close()
end

return InventoryScreen
```

---

# UIReferences

The project uses a utility called `UIReferences`.

This system abstracts UI references to avoid:

- Long UI paths
- Excessive `WaitForChild`
- Broken references after UI changes
- High maintenance costs

---

## Without UIReferences

```lua
local button = screen.Main.Container.Buttons.Play
```

---

## With UIReferences

```lua
local refs = UIReferences:Get(screen)

refs.PlayButton
```

---

# UI State Management

The project uses a centralized screen controller.

Goals:

- Ensure only one active screen
- Simplify transitions
- Centralize open/close logic
- Manage visual state consistently

---

## Example

```lua
UIStateManager:Open("Inventory")
```

---

# Service Pattern

Services contain business logic.

Services should not:

- Handle UI
- Contain visual logic
- Know client implementation details

---

## Example

```lua
function InventoryService:AddItem(player, itemId)
end
```

---

# Data Persistence

Data persistence is centralized through a player data handler.

Likely using:

- ProfileService
- DataStoreService
- Session locking
- Auto-save

---

## Goals

- Prevent data corruption
- Simplify migrations
- Centralize data access
- Avoid direct DataStore calls

---

# Data Structure

Player data is stored using a centralized template.

Example:

```lua
local DataTemplate = {
	coins = 0,
	inventory = {},
	index = {},
	settings = {}
}
```

---

# Modularization

Each system is independent.

Examples:

- Inventory
- Index
- Rebirth
- Shop
- Quest
- Daily Rewards

Each module may contain:

- Service
- Controller
- UI
- Configuration
- Dedicated communication flow

---

# Naming Conventions

| Type | Convention |
|---|---|
| Services | `SomethingService` |
| Controllers | `SomethingController` |
| Screens | `SomethingScreen` |
| Managers | `SomethingManager` |
| Utils | `SomethingUtil` |

---

# Code Organization

## Standard File Structure

```lua
-- Module
local Module = {}

-- Services

-- Requires

-- Constants

-- Variables

-- Local Functions

-- Public Functions

return Module
```

---

# Luau Typing

The project uses gradual typing with Luau.

Example:

```lua
local function getPlayerData(player: Player): PlayerData
end
```

Benefits:

- Better autocomplete
- Fewer bugs
- Easier maintenance
- Safer refactors

---

# Concurrency and Threading

The project avoids excessive thread creation.

Common practices:

- Controlled `task.spawn`
- Debounces
- Loading flags
- Canceling outdated operations

---

# Architecture Goals

The architecture was designed to:

- Scale easily
- Simplify onboarding
- Improve maintainability
- Reduce coupling
- Enable rapid feature expansion
- Improve readability

---

# Example Flow

```txt
Player clicks button
    ↓
Controller receives input
    ↓
RemoteManager sends event
    ↓
Service processes logic
    ↓
PlayerData gets updated
    ↓
Client receives update
    ↓
UI refreshes automatically
```

---

# Technologies

- Roblox Studio
- Luau
- RemoteEvents
- RemoteFunctions
- ProfileService
- Wally
- Rojo

---

# Dependencies

## Wally

```toml
[package]
name = "dobigtest/game"
version = "1.0.0"
realm = "shared"
```

---


