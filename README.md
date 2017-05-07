# Delivery

NotificationCenter wrapper for Swift.

### Features
* Strongly typed subscribtions for notifications
* Automatical management of observers’ lifecycle

## Installation

### Cocoapods

Add to your Podfile:
```ruby
pod 'Delivery', '~> 1.0'
```

### Carthage

Add to your Cartfile:
```ruby
github "aleksei-z/Delivery" ~> 1.0
```

## Usage

### Base example

```swift
// Story.swift
struct Story {
	let title: String
	let body: String
	let author: String
	let createdAt: Date
}

// Notification.Name+<SomeName>.swift
extension Notification.Name {
	static let newStories = Notification.Name("NewStoriesNotification")
}

// StoriesViewController.swift
import Delivery

class StoriesViewController: UITableViewController {
	private let _bag = TokensBag() // All tokens will be automatically invalidated when view controller will be about to be disposed.

	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default
			.subscribe(for: .newStories, [Story].self) {
				print($0)
        	}.add(to: _bag)
	}
}

// SomewhereInCode.swift
let stories = [Story(...), Story(...)]
NotificationCenter.default.post(name: .newStories, with: stories)
```

### Manual invalidation

```swift
private var _token: ObservationToken?
private let _bag = TokensBas()

// viewDidAppear
_token = NotificationCenter.default.subscribe(...)
NotificationCenter.default.subscribe(...).add(to: _bag)
NotificationCenter.default.subscribe(...).add(to: _bag)

// viewWillDisappear
_token = nil // or _token?.invalidate()
_bag.invalidate()
```

### Built-in notifications

```swift
NotificationCenter.default.subscribe(for: .UIApplicationSignificantTimeChange) { userInfo in
}.add(to: _bag)
```

### Keyboard notifications

```swift
NotificationCenter.default.subscribeForKeyboardWillShow { note in
}

NotificationCenter.default.subscribeForKeyboardDidShow { note in
}

NotificationCenter.default.subscribeForKeyboardWillHide { note in
}

NotificationCenter.default.subscribeForKeyboardDidHide { note in
}

NotificationCenter.default.subscribeForKeyboardWillChangeFrame { note in
}
```

## License

[MIT](https://en.wikipedia.org/wiki/MIT_License)
