import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("mascota")
                    .resizable()
                    .frame(width: 120, height: 120)
                
                VStack(alignment: .leading) {
                    Image("dollar")
                        .resizable()
                        .frame(width: 36, height: 36)

                    Text("$ 1200")
                    
                    Image("euro")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.top)
                    
                    Text("€ 1780")
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
