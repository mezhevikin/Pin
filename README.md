# Pin

📌 A tiny library that makes working with AutoLayout easier.

A library for those who don't want to use big libraries like SnapKit, but the standard NSLayoutConstraint creation seems too verbose.

### Example with Pin 😸

```swift
import UIKit
import Pin

class CurrencyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bodyView)
        bodyView.addSubviews([flagLabel, titleLabel, codeLabel])
        
        Pin.activate([
            bodyView.pin.horizontally(offset: 15).vertically(),
            flagLabel.pin.start().size(36).centerY(),
            titleLabel.pin.after(flagLabel, offset: 15).vertically(),
            codeLabel.pin.after(titleLabel, offset: 15).end().vertically()
        ])
    }
    
    let bodyView = UIView()
    let flagLabel = UILabel()
    let titleLabel = UILabel()
    let codeLabel = UILabel() 
    
}
```

<p align="center">
    <img src="https://user-images.githubusercontent.com/973364/199716786-3ba59b9e-1efa-4241-80e2-0fc54dfaf9c1.jpg" width="320">
</p>

[Original code](https://github.com/mezhevikin/PinExample/blob/master/PinExample/CurrencyCell.swift)

### Example without Pin 🙀

```swift
import UIKit

class CurrencyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(bodyView)
        bodyView.addSubview(flagLabel)
        bodyView.addSubview(titleLabel)
        bodyView.addSubview(codeLabel)
        
        NSLayoutConstraint.activate([
            bodyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            bodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            bodyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bodyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            flagLabel.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            flagLabel.centerYAnchor.constraint(equalTo: bodyView.centerYAnchor),
            flagLabel.widthAnchor.constraint(equalToConstant: 36),
            flagLabel.heightAnchor.constraint(equalToConstant: 36),
            
            titleLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: bodyView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor),
            
            codeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15),
            codeLabel.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            codeLabel.topAnchor.constraint(equalTo: bodyView.topAnchor),
            codeLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
        ])
    }
    
    let bodyView = UIView()
    let flagLabel = UILabel()
    let titleLabel = UILabel()
    let codeLabel = UILabel() 
    
}
```
### Methods

```swift
// titleLabel.leading == titleLabel.superview.leading
// Use addSubview(titleLabel) before it
titleLabel.pin.start()

// titleLabel.leading == iconView.leading
titleLabel.pin.start(iconView)

// titleLabel.leading == iconView.leading + 10
titleLabel.pin.start(iconView, offset: 10)

// titleLabel.leading == titleLabel.superview.safeAreaLayoutGuide.leading
titleLabel.pin.start(safe: true)

// titleLabel.trailing == titleLabel.superview.trailing - 10
titleLabel.pin.end(offset: -10)

// titleLabel.top == titleLabel.superview.top
titleLabel.pin.top()

// titleLabel.bottom == titleLabel.superview.bottom
titleLabel.pin.bottom()

// titleLabel.leading == titleLabel.superview.leading + 10
// titleLabel.trailing == titleLabel.superview.trailing - 10
titleLabel.pin.horizontally(offset: 10)

// titleLabel.top == titleLabel.superview.top
// titleLabel.bottom == titleLabel.superview.bottom
titleLabel.pin.vertically()

// contentView.leading == contentView.superview.leading + 10
// contentView.trailing == contentView.superview.trailing - 10
// contentView.top == contentView.superview.top + 10
// contentView.bottom == contentView.superview.bottom - 10
contentView.all(offset: 10)

// titleLabel.leading == iconView.trailing + 10
titleLabel.pin.after(iconView, offset: 10)

// iconView.trailing == titleLabel.leading - 10
iconView.pin.before(titleLabel, offset: -10)

// titleLabel.top == navigationBar.bottom + 10
titleLabel.pin.below(navigationBar, offset: 10)

// titleLabel.width == 200
titleLabel.pin.width(200)

// titleLabel.height == 20
titleLabel.pin.height(20)

// codeLabel.width == titleLabel.width
codeLabel.pin.width(titleLabel)

// codeLabel.height == titleLabel.height
codeLabel.pin.height(titleLabel)

// codeLabel.width <= titleLabel.width
codeLabel.pin.add(
    attr: .width,
    relation: .lessThanOrEqual,
    to: titleLabel,
    attr: .width
)
```

### Activate and deactivate

```swift
let top = titleLabel.pin.top()
top.activate()
top.deactivate()
```

Activation array of constraints is more efficient than activating each constraint individually.

```swift
Pin.activate([
    bodyView.pin.horizontally(offset: 15).vertically(),
    flagLabel.pin.start().size(36).centerY(),
    titleLabel.pin.after(flagLabel, offset: 15).vertically(),
    codeLabel.pin.after(titleLabel, offset: 15).end().vertically()
])
```

### Safe area

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubView(toolBar)
    toolBar.pin
        .start(safe: true)
        .end(safe: true)
        .top(safe: true)
        .height(55)
        .activate()
}
```

### Body

```swift
// Add body (bodyView fill view)
view.addBody(bodyView)
// Add body with safe area
view.addBody(bodyView, safe: true)
// Add body with insets 15
view.addBody(bodyView, insets: .all(15))
// Add body with horizontal insets 15
view.addBody(bodyView, insets: .horizontal(15))
```

### Priority

```swift
// Set priority for each constraint
titleLabel.pin
    .start().priority(.defaultHeight)
    .end().priority(.defaultLow)

// Set priority for all constraints
titleLabel.pin.start().end().priorityForAll(.defaultHeight)
```

### Access to NSLayoutConstraint

```swift
let start = titleLabel.pin.start().constraints.last
start.constant = 30
start.isActive = true
```

### Extensions

You can add own extensions:

```swift
extension Pin {
    
    public func horizontallyBetween(
        _ first: UIView,
        _ second: UIView,
        offset: CGFloat = 0
    ) -> Self {
        self.after(first, offset: offset)
            .before(second, offset: -offset)
    }
    
    public func verticallyBetween(
        _ first: UIView,
        _ second: UIView,
        offset: CGFloat = 0
    ) -> Self {
        self.add(attr: .top, to: first, attr: .bottom, constant: offset)
            .add(attr: .bottom, to: second, attr: .top, constant: -offset)
    }
    
}
```

### Right to left languages

Methods `start(), end(), after(), before()` support rtl languages by default. If you want to force direction then use:

```swift
semanticContentAttribute = .forceLeftToRight
```

### Swift Package Manager

```
https://github.com/mezhevikin/Pin.git
```
