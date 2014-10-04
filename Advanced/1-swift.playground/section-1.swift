
// To learn more about Swift, read Apple's Swift Programming Guide
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html

// As of iOS 8, Apple's API documentation includes both Swift and
// Objective C. You can access the documentation through Xcode or
// online at:
// https://developer.apple.com/library/ios/navigation/

import UIKit

//// Constant/Variable Declaration
// Declaring constants
let a: Int = 5
let b: String = "Hello, world"
//b = "Can't reassign constants"

// Variables can be reassigned
// Notice that type inference is checking
// the type of the right hand side of the
// assignment, so c is of type Int
// You can option click on an identifier to
// determine its  type
var c = 2
c = 3
c++


//// Two types of ranges
// Half-closed ranges, prints 5 times (0-5 exclusive)
for i in 0..<a {
    println(b)
}

// Closed ranges, prints 6 times (0-5 inclusive)
for i in 0...a {
    println(b)
}


//// Collections
// Can be passed in to Objective-C methods in place of NSArrays or NSDictionaries
// Arrays
let array: [Int] = [1, 2, 3, 4, 5]
let array2 = [Int]()

var marray = [Int]()
marray += [0]              // concatenation
marray.append(1)
marray

// Dictionaries
var cheeseRatings: [String : Int] = [:]
cheeseRatings["Gouda"] = 7
cheeseRatings["Smoked Gouda"] = 8
cheeseRatings["Cottage"] = 1
cheeseRatings.removeValueForKey("Gouda")


//// Structs - Value types (passed by value everywhere)
struct Wizard {
    // Stored properties
    let name: String
    var color: UIColor
    var power: Int
    
    // Can also add initializers, computed properties, and methods.
    // Looks the same as the class example below
}

let gandalf = Wizard(name: "Gandalf", color: UIColor.grayColor(), power: 10)

var saruman = Wizard(name: "Saruman", color: UIColor.whiteColor(), power: 9)
saruman.power -= 1

// Gandalf is constant, so you can't mutate his properties even
// if they're variables
// gandalf.power += 1

// You can mutate copies, however
var gandalfTheWhite = gandalf
gandalfTheWhite.color = UIColor.whiteColor()


//// Functions
func duel(a: Wizard, b: Wizard) -> Wizard {
    // Ternary operator is the same as in other languages
    return (a.power > b.power) ? a : b
}

let winner = duel(gandalf, saruman)


//// Playgrounds allow you to interactively develop UI
func wizardLabel(wizard: Wizard) -> UILabel {
    let frame = CGRect(x: 0, y: 0, width: 200, height: 20)
    
    // Notice that label is a constant reference (not value).
    // label can't ever be a different UILabel, but its properties
    // can be mutated
    let label = UILabel(frame: frame)
    label.text = "\(wizard.name) (lvl \(wizard.power))"
    label.backgroundColor = wizard.color
    label.textAlignment = .Center
    
    return label
}

// Click on the circles in the right sidebar
wizardLabel(gandalf)
wizardLabel(saruman)

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.addSubview(wizardLabel(winner))
view.backgroundColor = UIColor.orangeColor()

// Click on the circle in the right sidebar
view


//// Classes - Reference Types
class Rect : NSObject {
    // Access Control
    // Note that private means private to the _file_, not to the class
    private var width: CGFloat
    private var height: CGFloat
    
    // Designated initializer calls superclass's init
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        
        super.init()
    }
    
    // Convenience just means it calls the designated
    // initializer. You should only have one designated
    // initializer
    convenience override init() {
        self.init(width: 0, height: 0)
    }
    
    // Computed Properties
    // Just a clearer way to define get/set methods
    var area: CGFloat {
        return width * height
    }
    
    var perimeter: CGFloat {
        get {
            return 2 * (width + height)
        }
    }
}

// Classes are reference types, so you can mutate their variable properties
let r = Rect()
r.width = 1
r.height = 1

r.area
r.perimeter


class ViewController : UIViewController {
    override init() {
        super.init()
    }
    
    // Because UIViewController conforms to NSCoding,
    // you must implement this convenience initializer
    required convenience init(coder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        // Just like Objective-C.
    }
}


//// Generics
// Don't use this function in real code, it's just an example
func rest<T>(list: [T]) -> [T] {
    return Array(list[1..<list.count])
}

rest([0, 1, 2, 3]) // -> [1, 2, 3]
