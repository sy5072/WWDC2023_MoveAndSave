import SwiftUI

struct TrashView: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color(hex: "#48BDFF")
                VStack {
                    Text("As time goes by, a large amount of waste is being discharged and \nemerging as a social problem. \nAre you taking out the trash properly?")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Image("trash")
                        .imageScale(.large)

                    NavigationLink(destination: EarthView()) {
                        Text("Next")
                            .padding()
                            .foregroundColor(Color(hex: "#1B4456"))
                            .fontWeight(.bold)
                            .font(.title3)
                        
                    }
                    .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(.white)
                    .cornerRadius(10)
                    
                }
                
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
