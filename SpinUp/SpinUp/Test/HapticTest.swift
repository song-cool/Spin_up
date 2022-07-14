//
//  HapticTest.swift
//  SpinUp
//
//  Created by 송시원 on 2022/07/01.
//

//mapping function 참고...
import CoreHaptics
import SwiftUI

struct HapticTest: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack{
            Text("haptic")
            Spacer()
            Button("warning") { HapticManager.instance.notification(type: .warning) }.padding()
            Button("error") { HapticManager.instance.notification(type: .error) }.padding()
            Button("success") { HapticManager.instance.notification(type: .success) }.padding()
            Button("heavy") { HapticManager.instance.impact(style: .heavy) }.padding()
            Button("light") { HapticManager.instance.impact(style: .light) }.padding()
            Button("medium") { HapticManager.instance.impact(style: .medium) }.padding()
            Button("rigid") { HapticManager.instance.impact(style: .rigid) }.padding()
            Button("soft") { HapticManager.instance.impact(style: .soft) }.padding()
//            Button("custom") { complexSuccess() }.padding()
        }
        .onAppear(perform: prepareHaptics)
        .onTapGesture(perform: complexSuccess)
    }
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("err creating engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 5, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i*0.05)
            events.append(event)

        }
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct HapticTest_Previews: PreviewProvider {
    static var previews: some View {
        HapticTest()
    }
}

class HapticManager {
    // 서근
    static let instance = HapticManager()
    
    //어떤 타입의 피드백을 받을지 확인 후, 피드백을 만듦.
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
