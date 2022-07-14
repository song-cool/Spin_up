//
//  ContentView.swift
//  SpinUp
//
//  Created by GOngTAE on 2022/06/08.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    let gameManager: GameManager?
    
    @State var velocity: Double = 0
    
    
    var scene: SKScene {
        let scene = GameScene()
        //게임 화면의 크기 설정
        //화면에 꽉차게 설정
        scene.scaleMode = .resizeFill //A setting that defines how the scene is mapped to the view that presents it.
        scene.velocityDelegate = self
        return scene
    }
    
    init() {
        gameManager = GameManager.shared
        gameManager?.uiDelegate = self
    }
    
    var body: some View {
        
        NavigationView{
            ZStack {
                SpriteView(scene: scene)
                    .zIndex(1)
                
                VStack {
                    Text("\(velocity)")
                        .font(.title.bold())
                        .foregroundColor(.black)
                        
                    
                    Spacer()
                    NavigationLink(destination: AccelerationTest(), label: {
                        Text("TestView1")
                    })
                    .padding()
                    NavigationLink(destination: HapticTest(), label: {
                        Text("TestView2")
                    })
                    .padding()
                }
                .zIndex(2)
                
                
                
            }
        }
    }
}

extension ContentView {
    func velocityChanged(velocity: Double?) {
        self.velocity = velocity!
    }
}

extension ContentView: UIDelegate {
    func nextLevel(level: Int) {
        // 다음 레벨 핸들ㄹ
    }
    
    func gameOver() {
        // 게임 오버 핸들러
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
