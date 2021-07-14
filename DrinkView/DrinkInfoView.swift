import SwiftUI

struct DrinkInfoView: View {
    
    @Binding var showDrinkInfo:Bool
    @Binding var infoDrink:Drink
    
    @State var mainCabinet:Bool
    
    var body: some View{
        VStack(alignment: .leading){
            XButton(isShown: self.$showDrinkInfo)
            
            HStack{
                VStack(alignment: .leading){
                    Text(self.infoDrink.id).font(.title).fontWeight(.bold)
                    Text("\(self.infoDrink.volume)% Vol").font(.body)
                }
                
                
                Spacer()
                
                DrinkImageView(imageName: self.infoDrink.id)
            }.padding(.top)
            
            if !self.mainCabinet {
                Text(self.infoDrink.summary)
                    .layoutPriority(1)
                    .font(.callout)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
    
        }
    }
}