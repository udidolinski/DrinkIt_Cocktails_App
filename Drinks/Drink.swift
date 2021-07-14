import Foundation

struct Drink: Identifiable, Hashable{
    // drink name
    let id: String
    
    let category: String
    let volume: Int
    let summary: String
    
    init(id: String, category: String, volume: Int, summary: String) {
        self.id = id
        self.category = category
        self.volume = volume
        self.summary = summary
    }
    
    init() {
        self.init(id: "",category: "",volume: 0,summary: "")
    }
}
