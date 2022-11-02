// Mezhevikin Alexey https://github.com/mezhevikin/Pin

import UIKit

public final class Pin {
    
    public let view: UIView
    
    public init(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
    
    public var constrains = [NSLayoutConstraint]()
    
    public func add(
        attr attr1: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        to: UIView? = nil,
        attr attr2: NSLayoutConstraint.Attribute? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        safe: Bool = false
    ) -> Self {
        let to = to ?? superview
        let constrain = NSLayoutConstraint(
            item: view,
            attribute: attr1,
            relatedBy: relation,
            toItem: safe ? to.safeAreaLayoutGuide : to,
            attribute: attr2 ?? attr1,
            multiplier: 1,
            constant: constant
        )
        constrain.priority = priority
        return add(constrain)
    }
    
    public func add(_ constraint: NSLayoutConstraint) -> Self {
        constrains.append(constraint)
        return self
    }
    
    public func left(_ to: UIView? = nil, offset: CGFloat = 0, safe: Bool = false) -> Self {
        add(attr: .leading, to: to, constant: offset, safe: safe)
    }
    
    public func right(_ to: UIView? = nil, offset: CGFloat = 0, safe: Bool = false) -> Self {
        add(attr: .trailing, to: to, constant: offset, safe: safe)
    }
    
    public func top(_ to: UIView? = nil, offset: CGFloat = 0, safe: Bool = false) -> Self {
        add(attr: .top, to: to, constant: offset, safe: safe)
    }
    
    public func bottom(_ to: UIView? = nil, offset: CGFloat = 0, safe: Bool = false) -> Self {
        add(attr: .bottom, to: to, constant: offset, safe: safe)
    }
    
    public func width(_ to: UIView) -> Self {
        add(attr: .width, to: to)
    }
    
    public func width(_ width: CGFloat) -> Self {
        add(view.widthAnchor.constraint(equalToConstant: width))
    }
    
    public func height(_ to: UIView) -> Self {
        add(attr: .height, to: to)
    }
    
    public func height(_ height: CGFloat) -> Self {
        add(view.heightAnchor.constraint(equalToConstant: height))
    }
    
    public func size(_ size: CGFloat) -> Self {
        width(size).height(size)
    }
    
    public func centerX(_ to: UIView? = nil) -> Self {
        add(attr: .centerX, to: to)
    }
            
    public func centerY(_ to: UIView? = nil) -> Self {
        add(attr: .centerY, to: to)
    }
    
    public func center(_ to: UIView? = nil) -> Self {
        centerY(to).centerX(to)
    }
    
    public func after(_ to: UIView, offset: CGFloat = 0) -> Self {
        add(attr: .leading, to: to, attr: .trailing, constant: offset)
    }
    
    public func before(_ to: UIView, offset: CGFloat = 0) -> Self {
        add(attr: .trailing, to: to, attr: .leading, constant: offset)
    }
    
    public func below(_ to: UIView, offset: CGFloat = 0) -> Self {
        add(attr: .top, to: to, attr: .bottom, constant: offset)
    }
    
    public func above(_ to: UIView, offset: CGFloat = 0) -> Self {
        add(attr: .bottom, to: to, attr: .top, constant: offset)
    }
    
    public func horizontal(_ to: UIView? = nil, offset: CGFloat = 0) -> Self {
        left(to, offset: offset).right(to, offset: -offset)
    }
    
    public func vertical(_ to: UIView? = nil, offset: CGFloat = 0) -> Self {
        top(to, offset: offset).bottom(to, offset: -offset)
    }
    
    public func all(_ to: UIView? = nil, offset: CGFloat = 0) -> Self {
        vertical(to, offset: offset).horizontal(to, offset: offset)
    }
    
    public func prority(_ priority: UILayoutPriority) -> Self {
        if let last = constrains.last {
            last.priority = priority
        }
        return self
    }
    
    private var superview: UIView {
        guard let superview = view.superview else {
            fatalError("Superview is nil. Use addSubview() before it.")
        }
        return superview
    }
    
    public func activate() {
        NSLayoutConstraint.activate(constrains)
    }
    
    public func deactivate() {
        NSLayoutConstraint.deactivate(constrains)
    }
    
    public static func activate(_ all: [Pin]) {
        NSLayoutConstraint.activate(all.flatMap { $0.constrains })
    }
    
    public static func deactivate(_ all: [Pin]) {
        NSLayoutConstraint.deactivate(all.flatMap { $0.constrains })
    }
    
}

public extension UIView {
    
    var pin: Pin { Pin(view: self) }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    func addBody(
        _ body: UIView,
        safe: Bool = false,
        insets: UIEdgeInsets = .zero
    ) {
        addSubview(body)
        body.pin
            .left(offset: insets.left, safe: safe)
            .right(offset: -insets.right, safe: safe)
            .top(offset: insets.top, safe: safe)
            .bottom(offset: -insets.bottom, safe: safe)
            .activate()
    }
    
}

public extension UIEdgeInsets {
    
    static func horizontal(_ inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    static func vertical(_ inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }
    
    static func all(_ inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}
