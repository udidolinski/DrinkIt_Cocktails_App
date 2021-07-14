import SwiftUI

struct GridView: View {
    @EnvironmentObject var dbDrinks:DBDrinks
    
    // grid height
    private let heightEntry:CGFloat
    private let widthEntry:CGFloat
    
    // array divided to chunks (number of drinks in each column)
    private let userDrinks:[[String]]
   
    // edit the drinks in the cabinet
    @Binding var edit:Bool
    
    //drink info
    @Binding var showDrinkInfo:Bool
    @Binding var infoDrink:Drink

    /**
     initialize the  grid view and builds chunks of the array
     */
    init(gridHeight:CGFloat, drinks:Set<String>, edit:Binding<Bool>, showDrinkInfo:Binding<Bool>, infoDrink:Binding<Drink>) {
        self._edit = edit
        self._showDrinkInfo = showDrinkInfo
        self._infoDrink = infoDrink
        
        let NUM_OF_ROWS = Int((UIScreen.main.bounds.height * 0.6)/100)
        let NUM_OF_COLS = Int(ceil(UIScreen.main.bounds.width / ((UIScreen.main.bounds.height * 0.65) / CGFloat(NUM_OF_ROWS))))
        
        self.userDrinks = GridView.toArray(drinks: drinks, numOfRows: NUM_OF_ROWS)
        
        self.heightEntry = (gridHeight - 10) / CGFloat(NUM_OF_ROWS)
        self.widthEntry = (UIScreen.main.bounds.width / CGFloat(NUM_OF_COLS))
        
    }

    /**
     build by alphabetical order the chunks of the array
     */
    static func toArray(drinks:Set<String>, numOfRows:Int) -> [[String]] {
        
        var count = 0
        var arr = [[String]]()
        var innerArr = [String]()
        for item in drinks.sorted() {
            if (count < numOfRows){
                innerArr.append(item)
                count += 1
            }
            if (count == numOfRows) {
                arr.append(innerArr)
                innerArr = [String]()
                count = 0
            }
        }
        arr.append(innerArr)
        return arr
    }
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(self.userDrinks, id: \.self){ chunk in
                VStack(spacing: 0){
                    
                    ForEach(chunk, id: \.self){ drink in
                        ZStack(alignment: .bottom){
                         
                            // rectangle represents a shelf
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Charleston Green"))
                                .frame(width: self.widthEntry / 1.7, height: 5)
                                .shadow(color: .primary, radius: 2, x: 0.0, y: -2)
                            
                            CabinetDrinkView(drinkName: drink, edit: self.$edit, cabinetDrinkViewWidth: self.widthEntry)
                                .onTapGesture {
                                    if !self.edit{
                                        self.infoDrink = dbDrinks.drinksDict[drink]!
                                        self.showDrinkInfo.toggle()
                                    }
                                }
                                .frame(width: self.widthEntry, height: self.heightEntry)
                        }
                    }
                    Spacer(minLength: 0)
                }
            }
        }
    }
}


/**
 the view of each drink in the cabinet
 */
struct CabinetDrinkView: View {
    
    // drink name
    let drinkName:String
    
    
    @State private var delete =  false
    
    // edit the drinks in the cabinet - add (-) button to the  drink view
    @Binding var edit:Bool
    @State var cabinetDrinkViewWidth:CGFloat
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
            Text(drinkName)
                .layoutPriority(1)
                .frame(width: self.cabinetDrinkViewWidth - 20,height: 30)
                .multilineTextAlignment(.center)
                .opacity(self.edit == false ? 1: 0.3)
            ZStack{
                DrinkImageView(imageName: drinkName)
                    .opacity(self.edit == false ? 1: 0.3)
                if (self.edit){
                    Image(systemName: "minus.circle.fill").foregroundColor(.red).imageScale(.large)
                        .offset(x: -27, y: -22)
                        .onTapGesture(count: 1, perform: {
                            withAnimation(Animation.easeIn(duration: 0.5)){
                                self.delete.toggle()
                                self.user.userDrinks.remove(drinkName)
                                AppDelegate.staticSaveContext(context: self.managedObjectContext)
                            }
                        })
                }
            }
        }
        .offset(y: delete ? -150 : 0)
        .scaleEffect(CGSize(width: delete ? 0.1 : 1, height: delete ? 0.1 : 1))
    }
}