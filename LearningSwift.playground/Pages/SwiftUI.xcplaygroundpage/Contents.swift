import SwiftUI


// Views and screen size
// 1 Countainer Views offer space to other Views inside of them
// 2 Those Views chose a size they want to be in that container
// 3 The countainer View positions its Views

// Container Views
// The stacks (Hstack and Vstack) divide the space offered to THEM to their subviews
// ForEach defers to ITS CONTAINER to lay out hte Views inside the for each
// Modifiers like .padding() kind off contain the View they modify. Some can do layout




// Hstack and Vstack and Stacks in general
// They devide the space offered to them and divide that up to the Views inside of them.
// Do the least flexible sizing subviews first. Image is an inflexible view example.
// Text is a little more flexible but still not a lot. RoundedRectangle is flexible
// So Image first, then Text, then RoundedRectangle. If a view takes a certain amount
// of space, that space is removed from the availible pool, and the H/Vstack moves on
// to the next least flexbile View. Once its all done, the stack sizes ITSELF to fit
// all of the views.

// Work well with Hstack and Vstack:
// Spacer(minLength: CGFloat?) Takes all the space offered, draws nothing
// Used to add spacing for a platform. It defaults to the right ammount for
// the current platform when no argument is passed (or is nill, not sure TEST)
// Divider() Draws a dividing line in the layout direction.
// Put into a stack to draw a line between all the Views in that stack.
 
// Priorities can be overriden with .layoutPriority(Double)
//HStack {
//    Text("Important").layoutPriority(100) // Any floating point number
//    Image(systemName: "arrow.up") // default layout priority is 0
//    Text("Unimportant")
//}
// So the Important text will get space it needs first (you upped its prio)
// Then Image, than Unimportant text. If there is no more room, the text will
// be cut off "Unimpor.."

// Allignment:
// You can define how a stack must allign its objects by Vstack(allignment: .leading) {}
// This will correct it self for right to left text. (automatically correct for right to left text)





// Modifiers
// Modifiers like .padding return a View, often modifying it or even taken part in the layout.
// For example .padding offers the View it's called on a new View reduced by 10 points on
// each size. The View returned by .padding(10) will choose a size for itself which
// is 10 points larger on all sides. Cause it needs space for that padding.
// So the View that is returned by .padding(10) is different than before.
// .aspectratio is another one.

//HStack {
//    ForEach(viewmodel.cards) { card in
//        CardView(card: card).aspectRatio(2/3, ContentMode .fit)
//    }
//}
//.foregroundColor(Color.orange)
//.padding(10)

// So the View made with .padding(10) will be offered space. That view will offer
// a view with 10 points taken away (from whatever IT was offered)
// on each side to the View from .foregroundColor. Which will offer
// all of that space to HStack. Which will devide that space equaly to
// each .aspectRatio views in the for each. Each .aspectRatio view will set
// its width to its share of the HStacks width and it's height to match the 2/3
// ratio. OR it takes all the height it's offered and match the width. Whatever
// fits. .aspectRatio will finally offer all of its chosen size to CardView, which
// will use all of it.
// SO: the resulting size will be the result of HStack sizing itself to fit those
// .aspectRatio Views + 10 points on each size.




// Custom Views
// Custom Views like CardView take all the space offered to them. But they should
// adapt as well as possible. How should a View know what to take? GeometryReader!
// You wrap this GeometryReader View around your normal View's body. It has a parameter
// of type GeometryProxy. Which has a var named size: the space that is being
// offered by our container. (it's a struct IRL)
protocol GeometryProxy {
    var size: CGSize {get}
    func frame(in: CoordinateSpace) -> CGRect
    var safeAreaInserts: EdgeInsets {get}
}
// It always accepts the space offered to it!! You use to when you know
// the size that is offered and ajusting how your View looks BASED ON THAT!
// The safeAreaInsers is like the notch on the iPhone: don't draw here generally
// You can breakout of it by using .edgesIgnoringSafeArea([.top]) for example.


// Containers offer space using .frame() and position it using .position()








