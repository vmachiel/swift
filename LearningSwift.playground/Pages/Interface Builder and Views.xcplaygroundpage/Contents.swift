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














