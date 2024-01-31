import Foundation
import SwiftUI


struct PantryView: View {
    @State private var searchFill: String = ""
    var body: some View {
        ZStack{
            
            VStack{
                VStack{
                    Image(systemName: "chevron.back")
                    Text("Back")
                    
                }
                .foregroundColor(.white)
                Spacer()
                
                
            }
        }
    }
    
}
#Preview {
    PantryView()
}
