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

[Full code](https://github.com/mezhevikin/PinExample/blob/master/PinExample/CurrencyCell.swift)


### Activation

```swift
let pin = titleLabel.pin.top()
pin.activate()
pin.deactivate()
```

Activation array of constrains is more efficient than activating each constraint individually.

```swift
Pin.activate([
    bodyView.pin.horizontally(offset: 15).vertically(),
    flagLabel.pin.start().size(36).centerY(),
    titleLabel.pin.after(flagLabel, offset: 15).vertically(),
    codeLabel.pin.after(titleLabel, offset: 15).end().vertically()
])
```

### Priority

```swift
// Set priority for each constrain
titleLabel.pin
    .start().priority(.defaultHeight)
    .end().priority(.defaultLow)

// Set priority for all constrains
titleLabel.pin.
    start().end().priorityForAll(.defaultHeight)
```


### Access to NSLayoutConstrains

```swift
let start = titleLabel.start().constrains.last
start.constant = 30
start.isActive = true
```

### Right-to-Left languages

Pin supports rtl languages by default.

If you want to force direction then use:

```swift
semanticContentAttribute = .forceLeftToRight
```

### Swift Package Manager

```
https://github.com/mezhevikin/Pin.git
```
