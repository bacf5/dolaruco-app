import SwiftUI

struct ContentView: View {
    @State var dolar: Int
    @State var fetching = false
    @State var currentTime = Date.now
    var fetcher = FetchService()
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("mascota")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Image("dollar")
                        .resizable()
                        .frame(width: 36, height: 36)

                    Text("$ 1480")
                    
                    Image("euro")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.top)
                    
                    Text("€ 1780")
                        
                    
                    
                }
                .padding()
            }
            
            
//            if fetching {
//                ProgressView()
//            } else {
//                Text("Updated:")
//                Text("\(currentTime, style: .date)")
//                    
//            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
