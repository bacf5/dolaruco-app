import SwiftUI

struct ContentView: View {
    
    @State var currentDate = Date.now
    @StateObject private var vm: ViewModel
    
    init(vm: ViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        HStack() {
            Image("mascota")
                .resizable()
                .frame(width: 150, height: 150)
                
            
            VStack{
                Text("Dolar hoy \(currentDate, style: .date)")
                    .font(.title2)
                    .padding(.top)
                
                List(vm.dollars, id: \.nombre) { dolar in
                    HStack(alignment: .center){
                        VStack(alignment: .leading) {
                            Image("\(dolar.moneda)")
                                .resizable()
                                .frame(width: 24, height: 24)
                                
                            Text("\(dolar.nombre)")
                                .opacity(0.4)
//                            Divider()
                        }
                        
                        Spacer()
                        Text(dolar.venta.formatAsCurrency())
                    }
                }.task {
                    await vm.populateDollars()
                }
            }
        }
        .frame(width: 450, height: 450)
    }
}
    

#Preview {
    ContentView(vm: ViewModel())
}
