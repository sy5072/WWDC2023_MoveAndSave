import SwiftUI
import AVFoundation

struct GameView: View {
    @State var imageIndex: [Int] = [1,1,0,2,0,1,0,2,0,1,0,2,1,1,2,0,0,1,0,2,0,1,0,0,1,2,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,]
    @State var score: Int = 0
    @State var isCrushing: Bool = false
    @State var isCrushed: Bool = false
    @State var isSliced: Bool = false
    @State var numberOfTap: Int = 0
    @State var scale: CGFloat = 0.5
    @State var totalWidth = 0.0
    @State var isWashed: Bool = false
    @State var isWashing: Bool = false
    @State var lastDragPosition: DragGesture.Value?
    let positionsX = [UIScreen.main.bounds.width/3, UIScreen.main.bounds.width/4, UIScreen.main.bounds.width/3+32, UIScreen.main.bounds.width/4 - 24, UIScreen.main.bounds.width/3 + 20]
    let positionsY = [UIScreen.main.bounds.height/3, UIScreen.main.bounds.height/4, UIScreen.main.bounds.height/3+32, UIScreen.main.bounds.height/4 - 24, UIScreen.main.bounds.height/3 + 20]
    
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
    
    @ObservedObject var myTimer = MyTimer()
    
    init() {
        resetGame()
    }
    
    func resetGame() {
        isCrushing = false
        isCrushed = false
        isSliced = false
        numberOfTap = 0
        totalWidth = 0.0
        isWashed = false
        isWashing = false
        score = 0
        imageIndex = []
        for _ in 1...50 {
            imageIndex.append(Int.random(in: 0...2))            
        }
        self.myTimer.value = 30
        self.myTimer.isStopped = false
    }
    
    var body: some View {

        NavigationView {
            ZStack{
                Color(hex: "#48BDFF")
                
                if self.myTimer.isStopped == true {
                    VStack {
                        Text("Time's Up!!!")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 100))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            .onAppear(perform: {
                                playSound(sound: "Music Box Sound", type: "mp3")
                                
                            })
                            .onDisappear(perform: {
                                audioPlayer = nil
                            })
                        Text("You got \(score) score!!!! Great!!!\nLet's clean the Earth using the recycling method we learned today. \nThese small actions will come together and have a great effect on the Earth.")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                        Button(action: {
                            resetGame()
                        }) {
                            Text("Retry")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#1B4456"))
                        }
                        .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                    }                        
                } else {
                    VStack {
                        HStack {
                            Text("Score  \(score)")
                                .padding()
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#1B4456"))
                                .frame(width: 260, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(.white)
                                .cornerRadius(15)
                                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
                            Spacer()
                            Text("\(self.myTimer.value)")
                                .padding()
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(self.myTimer.value > 10 ? Color(hex: "#1B4456") : Color(.red))
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(.white)
                                .cornerRadius(40)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40))
                        }
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        if imageIndex[0] == 0 {
                            if isCrushed {
                                Image("crushedCan")
                                    .onAppear(perform: {
                                        playSound(sound: "Correct 1", type: "mp3")
                                        
                                    })
                                    .onDisappear(perform: {
                                        audioPlayer = nil
                                    })
                            } else if isCrushing {
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
                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                                imageIndex.removeFirst()
                                                isCrushed = false
                                                isCrushing = false
                                                score += 1
                                                numberOfTap = 0
                                            }
                                        }
                                    })
                            } else {
                                Image("can")
                                    .onTapGesture(count: 1, perform: {
                                        isCrushing = false
                                        isCrushing = true
                                        
                                        numberOfTap += 1
                                        if numberOfTap == 10 {
                                            isCrushed = true
                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                                imageIndex.removeFirst()
                                                isCrushed = false
                                                isCrushing = false
                                                score += 1
                                                numberOfTap = 0
                                            }
                                        }
                                    })
                            }
                        } else if imageIndex[0] == 1 {
                            if isSliced {
                                Image("slicedPetBottle")
                                    .onAppear(perform: {
                                        playSound(sound: "Correct 1", type: "mp3")
                                        
                                    })
                                    .onDisappear(perform: {
                                        audioPlayer = nil
                                    })
                                    .onTapGesture {
                                        imageIndex.removeFirst()
                                        isSliced = false
                                        score += 1
                                    }
                                
                            } else {
                                Image("petBottle")
                                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onChanged({ value in 
                                            if value.translation.height > 100 {
                                                withAnimation {                                        isSliced = true
                                                }
                                            } 
                                        })
                                            .onEnded({ value in 
                                                if value.translation.height > 100 {
                                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                                        imageIndex.removeFirst()
                                                        isSliced = false
                                                        score += 1
                                                    }
                                                }
                                            })
                                    )
                            }
                            
                        } else {
                            if isWashed {
                                Image("washedPlate")
                                    .onAppear(perform: {
                                        playSound(sound: "Correct 1", type: "mp3")
                                        
                                    })
                                    .onDisappear(perform: {
                                        audioPlayer = nil
                                    })
                                    .onTapGesture() {
                                        imageIndex.removeFirst()
                                        isWashed = false
                                        isWashing = false
                                        score += 1
                                        totalWidth = 0.0
                                    }
                            } else {
                                Image("plate")
                                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onChanged(({ value in
                                            self.lastDragPosition = value
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
                                                }
                                                if value.time.timeIntervalSince(self.lastDragPosition!.time) > 3 {
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                                        imageIndex.removeFirst()
                                                        isWashed = false
                                                        isWashing = false
                                                        score += 1
                                                        totalWidth = 0.0
                                                    }
                                                }
                                                
                                            } 
                                          })
                                        ).onEnded({value in 
                                        if value.time.timeIntervalSince(self.lastDragPosition!.time) > 3 {
                                        
                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                                imageIndex.removeFirst()
                                                isWashed = false
                                                isWashing = false
                                                score += 1
                                                totalWidth = 0.0
                                            }
                                        }
                                    }))
                            }
                        }
                        
                        Spacer()
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach (imageIndex, id:\.self) { index in
                                    if "\(index)" == "0" {
                                        Image("can")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                                        
                                        
                                    } else if "\(index)" == "1" {
                                        Image("petBottle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                                    } else {
                                        Image("plate")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                                    }
                                }
                            }
                            .background(.white)
                        }
                        
                        
                    }
                    if isWashing {
                        ForEach (0...5, id:\.self) { _ in
                            Circle ()
                                .foregroundColor(Color (red: .random(in: 0.9...1), green: .random(in: 0.9...1), blue: .random(in: 0.9...1)))
                                .opacity(0.4)
//                                .animation (.easeIn(duration: 10), value: isWashing
//                                )
                                .scaleEffect(self.scale * .random(in: 1...3))
                                .frame(width: .random(in: 50...100),
                                       height: CGFloat.random (in:50...100),
                                       alignment: .center)
                                .position(CGPoint(x: .random(in: UIScreen.main.bounds.width/3...2*UIScreen.main.bounds.width/3),y: .random (in:UIScreen.main.bounds.height/4...2*UIScreen.main.bounds.height/4)))
                            
                        }
                    }
                    
                    if isCrushing {
                        ForEach (0...5, id:\.self) { _ in
                            Image("boom")
                                .resizable()
                                .opacity(0.8)
                                .scaleEffect(self.scale * .random(in: 1...3))
                                .frame(width: .random(in: 40...60),
                                       height: CGFloat.random (in:40...60),
                                       alignment: .center)
                                .position(CGPoint(x: .random(in: 2*UIScreen.main.bounds.width/5...3*UIScreen.main.bounds.width/5),y: .random (in: 1*UIScreen.main.bounds.height/5...3*UIScreen.main.bounds.height/5)))
                        }
                    }    
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}

class MyTimer: ObservableObject {
    @Published var value: Int = 30
    @Published var isStopped: Bool = false
    
    init() {
        //간격        //반복되기때문에 true   //timer을 in 해준다.
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.value > 0 {
                self.value -= 1
            }
            if self.value == 0 {
                self.isStopped = true
            }
        }
    }
}
