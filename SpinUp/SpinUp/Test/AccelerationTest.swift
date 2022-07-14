//
//  AccelerationTest.swift
//  SpinUp
//
//  Created by 송시원 on 2022/07/01.
//
import CoreMotion
import SwiftUI

struct AccelerationTest: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var pitch = Double.zero
    @State private var yaw = Double.zero
    @State private var roll = Double.zero
    @State private var accX = Double.zero
    @State private var accY = Double.zero

    var body: some View {
        HStack{
        VStack(alignment: .leading){
            Text("Pitch: \(round(pitch))")
            Text("Yaw_: \(round(yaw))")
            Text("Roll_: \(round(roll))")
                .padding(.bottom)
            
            Text("AccX: \(round(accX))")
            Text("AccY: \(round(accY))")
        }
        .padding()
            Spacer()
        }
        //Vstack
        .onAppear {
            print("ON APPEAR")
            self.motionManager.startAccelerometerUpdates()

            self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                
                if let accelerometerData = motionManager.accelerometerData {
                    accY = accelerometerData.acceleration.y * -50
                    accX = accelerometerData.acceleration.x * 50
                }

                let attitude: CMAttitude = data.attitude
                
                print("pitch: \(attitude.pitch)")
                print("yaw: \(attitude.yaw)")
                print("roll: \(attitude.roll)")
                
                DispatchQueue.main.async {
                    self.pitch = attitude.pitch
                    self.yaw = attitude.yaw
                    self.roll = attitude.roll
                }
            }
        }//.onappear
    }
}

struct AccelerationTest_Previews: PreviewProvider {
    static var previews: some View {
        AccelerationTest()
    }
}
