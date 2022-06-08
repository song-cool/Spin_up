//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import Foundation

protocol UIDelegate {
    func nextLevel(level: Int)
    func gameOver()
}

class GameManager {
    
    //MARK: - Propeties
    static let shared = GameManager()
    var uiDelegate: UIDelegate?
    
    //MARK: - Initializers


    //MARK: - Methods
  
}
