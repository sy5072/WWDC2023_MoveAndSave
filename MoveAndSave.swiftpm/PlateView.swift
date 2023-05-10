import SwiftUI
import AVFoundation

struct PlateView : View {
    @State var totalWidth = 0.0
    @State var isWashed: Bool = false
    @State var isWashing: Bool = false
    @State var scale: CGFloat = 0.5
    @State var audioPlayer : AVAudioPlayer!
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Music Error")
            }
        }
    }
    var body: some View {
        NavigationView {
            ZStack{
                Color(hex: "#48BDFF")
                VStack {
                    
                    if isWashed {
                        Text("Well Done!!").foregroundColor(.white)
                            .font(.system(size: 60, weight: .bold))
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                            .onAppear(perform: {
                                                        playSound(sound: "Music Box Sound", type: "mp3")
                                                        
                                                    })
                            .onDisappear(perform: {
                                                        audioPlayer = nil
                                                    })
                                                Spacer()
                        Image("washedPlate")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            
                        NavigationLink(destination: CanView()) {
                            Text("Next")
                                .padding()
                                .foregroundColor(Color(hex: "#1B4456"))
                                .fontWeight(.bold)
                                .font(.title3)
                            
                        }
                        .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(.white)
                        .cornerRadius(10)
                                                Spacer()
                    } else {
                        Text("There's a container for delivery food that you finished. \nThere are food stains and oil stains on it, so you have to wipe it off. \nUse your fingers to wipe the container along the line.")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                        Image("plateWithArrow")
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onChanged(({ value in
                                    isWashing = true
                                    if value.translation.width < 0 {
                                        totalWidth -= value.translation.width
                                    } else {
                                        totalWidth += value.translation.width
                                    }
                                                                
                                    if totalWidth > 10000 {
                                        withAnimation {
                                            isWashing = false
                                            isWashed = true
                                            print(totalWidth)
                                        }
                                    } else {
                                        isWashing = true
                                    }
                                })))
                        Text("")
                            .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                Spacer()
                    }
                    
                    
                    
                }
                if isWashing {
                    ForEach (0...5, id:\.self) { _ in
                        Circle ()
                            .foregroundColor(Color (red: .random(in: 0.9...1), green: .random(in: 0.9...1), blue: .random(in: 0.9...1)))
                            .opacity(0.4)
                            .animation (.easeIn(duration: 10), value: isWashing
                            )
                            .scaleEffect(self.scale * .random(in: 1...3))
                            .frame(width: .random(in: 50...100),
                                   height: CGFloat.random (in:50...100),
                                   alignment: .center)
                            .position(CGPoint(x: .random(in: UIScreen.main.bounds.width/3...2*UIScreen.main.bounds.width/3),y: .random (in:UIScreen.main.bounds.height/4...2*UIScreen.main.bounds.height/4)))
                            
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}
