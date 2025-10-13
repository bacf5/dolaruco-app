import SwiftUI

struct ContentView: View {
        
    @State private var scale = 1.0
    @State private var showOtherCurrencies: Bool = false
    @State var currentDate = Date.now
    @StateObject private var vm: ViewModel
    let githubProject = URL(string: "https://github.com/bacf5/dolaruco-app")!
    
    
    init(vm: ViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        HStack{
            VStack {
                Image("mascota")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .shadow(color: .black, radius: 4)
                
                Button ("Other Currencies") {
                    showOtherCurrencies.toggle()
                }
                .buttonStyle(.glass)
                
                Button("Close App"){
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.glass)
                
                Button("About") {
                    NSApplication.shared.orderFrontStandardAboutPanel()
                }
                .buttonStyle(.glass)
                
                VStack {
                    Link(destination: githubProject) {
                        Image("github")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .onHover {
                                hover in withAnimation {
                                    scale = hover ? 1.2 : 1.0
                                }
                            }
                            .scaleEffect(scale)
                    }
                    
                }
            }
                
            VStack{
                Text("Dolar hoy \(currentDate, style: .date)")
                    .font(.title2)
                    .padding(.top)
                    .fontWeight(.semibold)
                
                VStack {
                    if (showOtherCurrencies == true) {
                        if vm.isLoading {
                            ProgressView("Loading...")
                        }
                        
                        List(
                            vm.otherCurrencies,
                            id: \.nombre
                        ) { otherCurrencies in
                            HStack(alignment: .center){
                                VStack(alignment: .leading) {
                                    Image("\(otherCurrencies.moneda)")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    
                                    Text("\(otherCurrencies.nombre)")
                                        .opacity(0.4)
                                    //                            Divider()
                                }
                                
                                Spacer()
                                Text(
                                    otherCurrencies.venta,
                                    format: .currency(code: "ARS")
                                )
                            }
                        }.scrollContentBackground(.hidden)
                    } else {
                        if (showOtherCurrencies == false) {
                            if vm.isLoading {
                                ProgressView("Loading...")
                            }
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
                                    Text(
                                        dolar.venta,
                                        format: .currency(code: "ARS")
                                    )
                                }
                            }.scrollContentBackground(.hidden)
                        }
                    }
                }
                .task {
                    await vm.populateDollars()
                    await vm.populateOtherCurrencies()
                }
            
            }
        }.frame(width: 500, height: 450)
        HStack{
            Text(
                "Made with ❤ - 2025 Bruno Caruso - Valores de: https://dolarapi.com/"
            )
            .font(.system(size: 8))
            .foregroundColor(Color.gray)
            .padding(.bottom)
        }
    }
}
    

#Preview {
    ContentView(vm: ViewModel())
}
