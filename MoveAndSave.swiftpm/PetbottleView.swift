import SwiftUI
import AVFoundation

struct PetBottleView : View {
    @State var isSliced: Bool = false
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
                    if isSliced == false {
                        Text("There's an empty plastic bottle with a label on it. \nLet's remove the label. Swipe the label with your finger")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        .multilineTextAlignment(.center)
                         .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))
                                                Spacer()
                        Image("petBottleWithArrow")
                            .frame(width: 300, height: 400)
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onChanged({ value in 
                                    if value.translation.height > 100 {
                                        withAnimation {                                        isSliced = true
                                        }
                                    } 
                                }))
                        Text("")
                        .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                Spacer()
                    } else {
                        Text("Well Done!!").foregroundColor(.white)
                            .font(.system(size: 60, weight: .bold))
                         .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))
                         .onAppear(perform: {
                             playSound(sound: "Music Box Sound", type: "mp3")
                             
                         })
                         .onDisappear(perform: {
                             audioPlayer = nil
                         })
                             //                             let song = NSDataAsset (name: "Music Box Sound")
                             //                             self.audio = try! AVAudioPlayer(data: song!.data, fileTypeHint: "mp3")
                             //                             self.audio.play()
                             Spacer()
                        Image("slicedPetBottle")
                                                    .frame(width: 300, height: 400)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                        NavigationLink(destination: PlateView()) {
                            Text("Next")
                                .padding()
                                .foregroundColor(Color(hex: "#1B4456"))
                                .fontWeight(.bold)
                                .font(.title3)
                            
                        }
                        .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(.white)
                        .cornerRadius(10)
                        .transition(.scale)
                                                Spacer()
                    }
                    

                    
                    
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}
