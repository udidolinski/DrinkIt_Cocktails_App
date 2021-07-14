import SwiftUI

struct DesignStyle {
    
    static func backgroundStyle() -> LinearGradient {
        //todo: decide on the background color
        return LinearGradient(gradient: Gradient(colors: [Color("backGroundL"),Color("backGroundM"),  Color("backGroundH")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static func buttonStyle() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("1"),Color("2"),  Color("3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    static func drinkOrCocktailButton(category:String) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors:
                        [Color("\(category)1"), Color("\(category)2"), Color("\(category)3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static func drinkButtonPressed() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("pressed")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}