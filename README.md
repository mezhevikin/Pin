# Pin

📌 A tiny library that makes working with AutoLayout easier.

A library for those who don't want to use big libraries like SnapKit, but the standard NSLayoutConstraint creation seems too verbose.

### Example

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

[Full code](https://github.com/mezhevikin/PinExample/blob/master/PinExample/CurrencyCell.swift)


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
        .top(safe: true)
        .horizontally()
        .height(55)
        .activate()
}
```

Add body to safe area with insets 15 pixels.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.addBody(
        contentView,
        safe: true,
        insets: .all(15)
    )
}
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

Pin supports rtl languages by default. If you want to force direction then use:

```swift
semanticContentAttribute = .forceLeftToRight
```

### Swift Package Manager

```
https://github.com/mezhevikin/Pin.git
```
