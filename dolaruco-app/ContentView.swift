import SwiftUI

struct ContentView: View {
    
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
                
            
                    Button{
                        NSApplication.shared.terminate(nil)
                    } label: {
                    Text("Close App")
                    }
                
                VStack {
                    Link(destination: githubProject) {
                        Image("github")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
                
            VStack{
                Text("Dolar hoy \(currentDate, style: .date)")
                    .font(.title2)
                    .padding(.top)
                    .fontWeight(.semibold)
                
                VStack {
                    if vm.isLoading {
                        ProgressView("Cargando...")
                    } else {
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
                                Text(dolar.venta, format: .currency(code: "USD"))
                            }
                        }.scrollContentBackground(.hidden)
                    }
                }.task {
//                    await vm.populateDollars()
                }
            
            }
        }.frame(width: 500, height: 450)
        HStack{
            Text("Copyright © 2025 Bruno - Valores de: https://dolarapi.com/")
                                .font(.system(size: 8))
                                .foregroundColor(Color.gray)
                                .padding(.bottom)
        }
    }
}
    

#Preview {
    ContentView(vm: ViewModel())
}
