import SwiftUI

/**
 the main cabinet view, grid from user drinks
 */
struct LiquorCabinetView: View {
    // user's drinks
    let userDrinks:Set<String>
    
    private let height = UIScreen.main.bounds.height * 0.6
    
    // edit the drinks in the cabinet
    @Binding var edit:Bool
    
    @Binding var showDrinkInfo:Bool
    
    @Binding var infoDrink:Drink
   

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false){
            // grid of drinks
            GridView(gridHeight: self.height, drinks: self.userDrinks, edit: $edit, showDrinkInfo: $showDrinkInfo, infoDrink: $infoDrink)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: self.height)
    }
}