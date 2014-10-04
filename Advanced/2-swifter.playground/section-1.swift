
// http://objc.io is a great resource for learning more advanced iOS
// development. The latest issue is all about Swift. Definitely worth a read:
// http://www.objc.io/issue-16/index.html

// http://subjc.com is similar, but focuses on implementing custom UI

import UIKit

let frame = CGRect(origin: CGPointZero, size: CGSize(width: 200, height: 200))

//// Downcasting
// We've explicitly cast scrollView as a UIView, so there's
// lost type information
let scrollView: UIView = UIScrollView(frame: frame)

// Can freely access UIView properties/methods
scrollView.backgroundColor = UIColor.orangeColor()

// But you must downcast (cast to a subclass) to access
// UIScrollView properties/methods
(scrollView as UIScrollView).contentOffset = CGPointZero

// Use the optional form (as?) (more on that later) when the downcast
// might fail. Otherwise, use the forced form (as)
let failure = scrollView as? UILabel // -> nil, because the downcast failed
// let crash = scrollView as UILabel

// Numeric types don't really support downcasting. You
// have to use initializers instead.
// Returns CGFloat between 0 and 1.
func randf() -> CGFloat {
    // arc4random() returns UInt32, so must be converted
    // Arithmetic is only defined for values of the same type
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX)
}


//// Any/AnyObject
let anythingGoes: [String : Any] = [
    "backgroundColor" : UIColor.grayColor(),
    "frame" : CGRect(x: 0, y: 0, width: 200, height: 100),
    "text" : "Would you look at that"
]

// This is BAD because it's unclear to the compiler what the types are.
// You end up having to cast things manually
func label(params: [String : Any]) -> UILabel {
    let label = UILabel(frame: params["frame"] as CGRect)
    label.backgroundColor = params["color"] as? UIColor
    label.text = params["text"] as? String
    return label
}

// A similar issue plagues JSON parsing
let json = "{\"key\" : 2.4, \"anotherKey\" : [1, 2, 3, 4]}".dataUsingEncoding(
    NSUTF8StringEncoding,
    allowLossyConversion: false
)

// Compiler thinks parsed is AnyObject?, which is a pain to deal with
let parsed: AnyObject? = NSJSONSerialization.JSONObjectWithData(
    json!,
    options: nil,
    error: nil
)


//// Optionals (or, What's the deal with those question marks?)
// Swift normally doesn't allow nil because it makes programs harder to
// reason about and opens up the possibility of crashes. Optionals are a
// way to use nil safely in Swift.
let optional: Any? = nil

let a: Int = 3
let b: Int? = 4

// Unwrapping Optionals
// To get the value out of an optional, it must be unwrapped using the
// unwrap (!) operator.
let unwrapped: Int = b!
let c = sqrt(Double(a * a + b! * b!))

// Attempting to unwrap a nil value will crash the app
let nope: Int? = nil
// let crash = nope!

// Optional Binding binds some optional expression to a non-optional
// if possible.
if let b = b {
    // Not that the optionally bound 'b' is bound in a different
    // scope. It's not referencing the original at all.
    let c = sqrt(CGFloat(a * a + b * b))
}

if var b: Int = nil as Int? {
    // Never executes
} else {
    // Always executes
}

// Implicity Unwrapped Optionals
// Still optional types, but unwrapping is automatic

// Used mainly with Objective-C interoperability. The Cocoa APIs often expect
// nil parameters or properties. Implicitly unwrapped optionals reduce the amount
// of manual unwrapping that needs to happen.
var implicit: Int! = 45

implicit * implicit
implicit! * implicit!
if let i = implicit {
    // ...
}

// Implicitly unwrapped optionals will still crash if a nil is unwrapped
implicit = nil
//let oops = implicit * implicit


// Optional Chaining allows you to dig into nested optional properties
// without checking each level. It shortcircuits at the first failure.
let button: UIButton? = nil
let text = button?.titleLabel?.text

if let text = button?.titleLabel?.text {
    // ...
}


//// Tuples
let hosts: [(String, String, Int)] = [("Oprah", "Winfrey", 60), ("Maury", "Povich", 75)]

for (first, last, age) in hosts {
    // String interpolation
    let name = "\(first) \(last)"
}


//// Extensions
// Like categories in Objective-C. You can add initializers, 
// instance/class methods, and computed properties. Note that
// there is no way to add a stored property with an extension.
extension UIColor {
    // Class methods are the same as in other languages
    class func rand() -> UIColor {
        return UIColor(red: randf(), green: randf(), blue: randf(), alpha: 1)
    }
    
    
    // It's always annoying to get the components from a UIColor.
    // It would be much easier  to provide properties once
    private var colorSpaceModel: CGColorSpaceModel {
        return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor))
    }
    
    private var canProvideRGBComponents: Bool {
        return (colorSpaceModel.value == kCGColorSpaceModelRGB.value) ||
            (colorSpaceModel.value == kCGColorSpaceModelMonochrome.value)
    }
    
    private var isMonochrome: Bool {
        return colorSpaceModel.value == kCGColorSpaceModelMonochrome.value
    }
    
    var r: CGFloat? {
        get {
            if canProvideRGBComponents {
                return CGColorGetComponents(self.CGColor)[0]
            }
            return nil
        }
    }
    
    var g: CGFloat? {
        get {
            if canProvideRGBComponents {
                return CGColorGetComponents(self.CGColor)[isMonochrome ? 0 : 1]
            }
            return nil
        }
    }
    
    var b: CGFloat? {
        get {
            if canProvideRGBComponents {
                return CGColorGetComponents(self.CGColor)[isMonochrome ? 0 : 2]
            }
            return nil
        }
    }
    
    var a: CGFloat {
        get {
            let numComponents = CGColorGetNumberOfComponents(self.CGColor)
            return CGColorGetComponents(self.CGColor)[numComponents - 1]
        }
    }
}

extension UIView {
    convenience init(frame: CGRect, backgroundColor: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
}

extension CGRect {
    // Same computed properties as last week
    var area: CGFloat {
        return width * height
    }
    
    var perimeter: CGFloat {
        get {
            return 2 * (width + height)
        }
    }
    
    // Some new computed properties
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin = CGPoint(
                x: newValue.x - width / 2,
                y: newValue.y - height / 2
            )
        }
    }
    
    var aspectRatio: CGFloat {
        get {
            return width / height
        }
        set {
            // Must define a getter to define a setter
            let oldCenter = center
            
            // newValue is the value on the right hand side of the assignment
            // Can call getter in the setter
            if newValue < aspectRatio {
                size.width *= newValue
            } else {
                size.height /= newValue
            }

            center = oldCenter
        }
    }
    
    func withAspectRatio(aspectRatio: CGFloat) -> CGRect {
        var result = CGRect(origin: origin, size: size)
        result.aspectRatio = aspectRatio
        return result
    }
}

let background = UIView(
    frame: frame,
    backgroundColor: UIColor.rand()
)
let foreground = UIView(
    frame: background.bounds.withAspectRatio(1.33),
    backgroundColor: UIColor.rand()
)
background.addSubview(foreground)


//// Closures
// Analagous to blocks in Objective-C.
let inc: (CGFloat -> CGFloat) = {(x: CGFloat) -> CGFloat in x + 1 }
let dec: (CGFloat -> CGFloat) = {x in x - 1 }

inc(2.5)
dec(2.5)

[1, 2, 3].map(inc)

let even: (Int -> Bool) = { $0 % 2 == 0 }
[1, 2, 3].filter(even)


//// Generics Revisited
// Returns a closure that is the composition of the closures
// f and g. Essentially: compose(f, g)(x) == g(f(x))
func compose<T, U, V>(f: (T -> U), g: (U -> V)) -> (T -> V) {
    return { return g( f($0) ) }
}

compose(inc, inc)(randf())


func zipmap<T, U>(keys: [T], values: [U]) -> [T : U] {
    var result = [T : U]()
    
    for i in 0..<min(keys.count, values.count) {
        result[keys[i]] = values[i]
    }
    
    return result
}

let zipped = zipmap(["Oprah Winfrey", "Maury Povich"], [60, 75])

func nonNil<T>(xs: [T?]) -> [T] {
    var result = [T]()
    
    for x in xs {
        if let x = x {
            result.append(x)
        }
    }
    
    return result
}

nonNil([0, nil, 1, nil, 2, nil])
