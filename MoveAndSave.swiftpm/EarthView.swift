import SwiftUI

struct EarthView : View {
    var body: some View {
        NavigationView {
            ZStack{
                Color(hex: "#48BDFF")
                VStack {
                    Text("The Earth we live on is suffering from environmental destruction, \nglobal warming, and climate change, and our lives are in danger.\nLet's learn the right way to recycle to protect \nour planet and live together.").foregroundColor(.white)
                        .font(.largeTitle)
                                            .multilineTextAlignment(.center)
                    Image("earth")
                        .imageScale(.large)
                    NavigationLink(destination: PetBottleView()) {
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
        .navigationBarBackButtonHidden(true)
    }
}
