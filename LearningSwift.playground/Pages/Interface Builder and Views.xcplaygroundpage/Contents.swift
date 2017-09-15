import UIKit
// A View is created inside your main ViewController when that is created.
// A view is a box, in which things are drawn. 


// You defined coordinates with CGFloat (core graphics float). They are special 
// Floats/Doubles
let xCoor: CGFloat = 37.0
let yCoor: CGFloat = 55.2
// You define a CGPoint on the View with
var point = CGPoint(x: xCoor, y: yCoor)
// Operations: move the point:
point.y -= 30
point.x += 20.0
point

// You can define a size within a view as a struct, it's an area:
var size = CGSize(width: 100.0, height: 50.0)
// and change that size:
size.width += 42.5
size.height += 75
size

// And than you can use that size in a CGRect, which defines an origin and a size
let rect = CGRect(origin: point, size: size)
// OTHER INITS
let rect2 = CGRect(x: 40.0, y: 25.0, width: 30, height: 30)
// It has methods like:
rect.minX  // left edge
rect.midY  // Midpoint vertically
rect.intersects(rect2)  // Does it intersect with -> Bool
rect.contains(point)  // Does it contain a point -> Bool

// 0,0 is in the UPPER LEFT!!!! NOT CART. COORDS!!
// INCREASING Y is thus going DOWN!

// Units that you draw are points not pixels. You know the 1x, 2x and 3x rendering. 
// 3GS and 4 have the same ammount of points, but 4 has 4X (2x2) the ammount of pixels.
// You draw with point system, and iOS will render.
// Check the pixels per point (1,2 or 3) with in your project.
let contentScaleFactor: CGFloat  // get



// Bounds: in your coor system, what is the space you have to draw in?
// What are the bounds of your view
var bounds: CGRect  // get

// A view also has properties on where it is in it's superviews coor system
// These aren't used for drawing, but just to indicate where the whole view is inside
// its super
var center: CGPoint  // where is the center
var frame: CGRect  // the rect of the view

// !!!!!!!!!!!
// frame.size and bounds.size can be different because the view might be rotated
// or translated. SO BOUNDS indicates in ITS COORD SYSTEM what the bounds are, and FRAME
// indicates what are the view ACTUALLY takes up in its SUPERVIEW!
// So FRAME AND CENTER position a view in a superview and BOUNDS indicates where you'll
// actually be drawing
// !!!!!!!!!!!



// Creating views:
// You drag a generic view into the interface builder, inspect and change it's class to
// your custom subclass (usually of UIView).

// or in code.. sometimes. Something like this: UIlabel example
let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
let label = UILabel(frame: labelRect)
label.text = "Hello"
// You would add it to a top level view with 
// nameOfTopView.addSubview(label)


// You create custom view to draw custom things or handle custom touch events
// Drawing:
// You override func draw(_ rect: CGRect). YOU NEVER CALL THIS FUNC YOURSELF. The 
// controller does that. That rect is a sub area that you draw in.
// If you do need to draw you call UIView.setNeedsDisplay(_ rect: CGRect) to redraw 
// an area



// PATHS and CoreGraphics
// you can draw by defining paths or UIBezierPath class. You have to:
// 1. Get a context to draw in: UIGraphicsGetCurrentContext()
// 2. Create paths (lines, arcs etc)
// 3. Set drawing attributes like color, font, texture, linewidth etc.
// 4. Stroke or fill the paths with the attributes

// UIBezierPath auto draws in the current context, has methods to draw (lineto, arcs),
// set attributes (linewidth). UIColor can be used to set storkes and fill colors.
// example:
let path = UIBezierPath()
// Draw a triangle: move to a point and draw from that point to another. Then to another,
// and finally back to where you started by calling close
path.move(to: CGPoint(x: 80, y: 50))  // Starting
path.addLine(to: CGPoint(x: 140, y: 150))  // First line
path.addLine(to: CGPoint(x: 140, y: 150))  // Second Line
path.close()  // Close by going back to the start

// So now the path is set, now you stroke and fill it
UIColor.green.setFill()  // You actually call a color and tell it to fill
UIColor.red.setStroke()  // Set the line to red
path.lineWidth = 3.0  // the linewidth is property of path
path.fill()   // Fill with green
path.stroke()  // Stroke the red line.
// contains method
path.contains(CGPoint(x: 130, y: 100))


// UIColor and transparency
// UIcolor sets colors
// UIViews have a background color property
let green = UIColor.green
let randomColor = UIColor.init(red: 0.3, green: 0.5, blue: 0.4, alpha: 1.0)
let transparentYellow = UIColor.yellow.withAlphaComponent(0.5)  // 0 is transparent
// If you want to use transparency, set the views opaque = false
// Make the entire view transparent by setting alpha = 0.0
// subviews are layered on top of each other. You can hide a layer with hidden = false


// Text.
// You can use UILabel to draw text, done with calculator. 
// Or you use NSAttributedString, which is a string like object with attributes like
// color etc. 
// You can set the attributes of a attributedstring by sending it a dictionary with
// attribute keys and their values, and an NSRange to apply them to.
let attributes = [NSForegroundColorAttributeName: UIColor.green]
let text = NSAttributedString(string: "Hello", attributes: attributes)


text.draw(at: CGPoint(x: 40.0, y: 30.0))  // Draw it with that point at upperleft corner
let textSize: CGSize = text.size()  // How much space it'll take up
// It's an old style.. so you have to make it an
let mutableText = NSMutableString(string: "Test")


// Fonts  (mostly set in interface builder)
// Get a font in code using a UIFfont Type Method. It takes an enum of availible
// kinds of text. These give preferred fonts, for users to see.
let chosenFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
let chosenFont2 = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
// System fonts go on buttons etc.
let systemFont = UIFont.systemFont(ofSize: 12.0)
let boldSystemFont = UIFont.boldSystemFont(ofSize: 14.0)


// Drawing images
// Use UIImageView
let image: UIImage? = UIImage(named: "Some Image.jpg")
// This will (in a project) add it to Images.xcassets. You can also get them from the file
// system or draw them yourself using Core Graphics.
// Draw it at a point, inside a CGRect, or tile it into a CGRect
image?.draw(at: point)  // etc
// Whe UIView changes it size, it'll stretch or squich and image into the new size. Ask for
// a redraw using UIView.contentMode.  You can ask it to put it somewhere or scale it.
// OR Simply ask for a .redraw  This is possible in interface builder's inspector.


// Use convert to convert a point (like center) from one coor system to another.
let skullCenter = convert(center, from: superview)













