import Foundation

import SwiftUI
 
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            // placeholder text
            TextField("Search", text: $text, onEditingChanged: {
                _ in self.isEditing = true
            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        // magnifyingglass image before the text
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        // add x to exit the search bar
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                
            // add Cancel button to close the keyboard
            if isEditing {
                Button(action: {
                    UIApplication.shared.endEditing()
                    self.isEditing = false
                    self.text = ""
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .animation(.default)
            }
        }.padding(.horizontal, 7)
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}