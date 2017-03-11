# Delivery

NotificationCenter wrapper for Swift.

### Features
* Generic subscribtions for notifications
* Automatical management of observers’ lifecycle

## Installation

### Cocoapods

Add to your Podfile:
```ruby
pod 'Delivery', '~> 1.0'
```

You can add following lines to your Podfile…
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if target.name == 'Delivery' 
        config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] ||= ['DECLARE_STATIC']
      end
    end
  end
end
```
… to declare static methods in addition to instance ones.

### Carthage

Add to your Cartfile:
```ruby
github "aleksei-z/Delivery" ~> 1.0
```

NOTE: Unfortunately you cannot use static methods and Carthage.

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
NotificationCenter.default.subscribe(for: .UIKeyboardWillChangeFrame) { userInfo in
}.add(to: _bag)
```

## License

[MIT](https://en.wikipedia.org/wiki/MIT_License)
