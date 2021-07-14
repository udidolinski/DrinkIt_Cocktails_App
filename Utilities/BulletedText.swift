import SwiftUI

struct BulletedText: View {
    
    let text:String

    var body: some View {
        HStack(alignment: .top){
            Text("• ")
            Text(text)
        }
    }
}


struct BulletedGuideText: View {
    
    let text:String

    var body: some View {
        HStack(alignment: .top){
            Text("• ").font(.body).bold()
            Text(text).font(.body).bold()
        }
    }
}