import SwiftUI

struct GameStartView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(hex: "#48BDFF")
                VStack {
                    Text("Now you've taken a step toward the recycling master. \nThere is still a lot of trash out there though.\nLet's clean it!! You can save our earth !!!!").foregroundColor(.white)
                        .font(.system(size:42))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 200, leading: 0, bottom: 50, trailing: 0))
                    
                    Spacer()
                    
                    NavigationLink(destination: GameView()) {
                        Text("Game Start!")
                            .foregroundColor(Color(hex: "#1B4456"))
                            .font(.system(size: 30, weight: .bold))
                    }
                    .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(.white)
                    .cornerRadius(125)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 200, trailing: 0))
                    
                    Spacer()
                }
                
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}
