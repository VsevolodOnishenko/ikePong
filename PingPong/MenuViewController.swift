//
//  MenuViewController.swift
//  PingPong
//
//  Created by Vsevolod Onishchenko on 12.01.2018.
//  Copyright © 2018 Vsevolod Onishchenko. All rights reserved.
//

import UIKit

enum GameType {
    case easy
    case medium
    case hard
    case twoPlayers
}

class MenuViewController: UIViewController {
    
    @IBAction func twoPlayersButtonPressed(_ sender: Any) {
        moveToGame(gameType: .twoPlayers)
    }
    
    @IBAction func easyModeButtonPressed(_ sender: Any) {
        moveToGame(gameType: .easy)
    }
    
    @IBAction func mediumModeButtonPressed(_ sender: Any) {
        moveToGame(gameType: .medium)
    }
    
    @IBAction func hardModeButtonPressed(_ sender: Any) {
        moveToGame(gameType: .hard)
    }
    
    func moveToGame(gameType: GameType) {
        let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = gameType
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
}
