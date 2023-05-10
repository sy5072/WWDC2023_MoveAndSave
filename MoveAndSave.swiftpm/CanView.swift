import SwiftUI
import AVFoundation

struct CanView : View {
    @State var isCrushed: Bool = false
    @State var isCrushing: Bool = false
    @State var scale: CGFloat = 0.5
    @State var numberOfTap: Int = 0
    @State var isEffectHidden: Bool = false
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
                    
                    if isCrushed {
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
                        Image("crushedCan")
                            .onTapGesture(count: 10, perform: {
                                withAnimation(){
                                    isCrushed = true
                                }
                            })
                                                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        NavigationLink(destination: GameStartView()) {
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
                    } else if isCrushing {
                        Text("Please crumple up the empty cans and throw them away with other can. \nLet's touch the can several times and crumple it.")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))
                        Spacer()
                        Image("beingCrushedCan")
                            .frame(width:300, height: 400)
                            .modifier(ShakeEffect(shakes: numberOfTap * 2))
                            .onTapGesture(count: 1, perform: {
                                isCrushing = false
                                isCrushing = true
                                
                                numberOfTap += 1
                                if numberOfTap == 10 {
                                    isCrushed = true
                                    isCrushing = false
                                }
                            })
                        
                        
                        Text("")
                            .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Spacer()
                    } else {
                        Text("Please crumple up the empty cans and throw them away with other can. \nLet's touch the can several times and crumple it.")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))
                        Spacer()
                        Image("can")
                            .frame(width:300, height: 400)
                            .modifier(ShakeEffect(shakes: numberOfTap * 2))
                            .onTapGesture(count: 1, perform: {
                                isCrushing = false
                                isCrushing = true
                                
                                numberOfTap += 1
                                if numberOfTap == 10 {
                                    isCrushed = true
                                    isCrushing = false
                                }
                            })

                        
                        Text("")
                            .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                Spacer()
                    }
                    
                    
                    
                }
                if isCrushing {
                    ForEach (0...5, id:\.self) { _ in
//                        Circle ()
//                            .foregroundColor(Color (red: .random(in: 0.3...1), green: .random(in: 0.3...1), blue: .random(in: 0.3...1)))
                        Image("boom")
                            .resizable()
                            .opacity(1)
                            .animation (Animation.spring (dampingFraction: 0.3)
                                .repeatForever(autoreverses: true)
                                .speed (.random(in: 0.4...1))
                                .delay(.random (in: 0...1)), value: scale
                            )
                            .scaleEffect(self.scale * .random(in: 1...3))
                            .frame(width: .random(in: 40...60),
                                   height: CGFloat.random (in:40...60),
                                   alignment: .center)
                            .position(CGPoint(x: .random(in: 2*UIScreen.main.bounds.width/5...3*UIScreen.main.bounds.width/5),y: .random (in: 2*UIScreen.main.bounds.height/5...3*UIScreen.main.bounds.height/5)))
                    }
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}


struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        print(position)
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}
