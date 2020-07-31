//
//  View.swift
//  ConwaysGOL
//
//  Created by Ezra Black on 7/27/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class View: UIViewController {
    
    //MARK - Properties
    
    var buttons: [UIButton] = []
    var buttonColor = UIColor.systemRed {
        didSet {
            updateGrid()
        }
    }
    
    //MARK - Outlets
    
    @IBOutlet weak var genLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var gameView: GameView!
    @IBOutlet weak var playButtonLabel: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.grid.delegate = self
        buildButtons()
        presentGeneration()
        presentPopulation()
        updateGrid()
        
    }
    
    //MARK - Actions
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        pause()
        gameView.gridClear()
    }
    
    
    @IBAction func examplesButtonTapped(_ sender: Any) {
        pause()
        
        let AC = UIAlertController(title: "Example Patterns", message: "Select a Pattern:", preferredStyle: .alert)
        
        AC.addAction(UIAlertAction(title: "Random Pattern", style: .default) { _ in
            self.gameView.patterns(pattern: .random)
        })
        AC.addAction(UIAlertAction(title: "Blinker", style: .default) { _ in
            self.gameView.patterns(pattern: .blinker)
        })
        AC.addAction(UIAlertAction(title: "Glider", style: .default) { _ in
            self.gameView.patterns(pattern: .glider)
        })
        AC.addAction(UIAlertAction(title: "Pulsar", style: .default) { _ in
            self.gameView.patterns(pattern: .pulsar)
        })
        AC.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(AC, animated:  true, completion:  nil)
        
        
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if gameView.timerRunning {
            pause()
        } else {
            playButtonLabel.isSelected = true
            gameView.timerStart()
        }
    }
    
    @IBAction func stepButtonTapped(_ sender: Any) {
        gameView.step()
    }
  
    @objc private func buttonTapped(_ sender: UIButton) {
     gameView.tappedCell(at: sender.tag)
    }
    
    private func pause() {
        playButtonLabel.isSelected = false
        gameView.cancelTime()
    }
    
    private func buildButtons() {
        var index = 0
        var topOffset = CGFloat(0)
        var leadingOffset = CGFloat(0)

        for y in 0..<gameView.grid.size {
            for x in 0..<gameView.grid.size {
                print(index, x, y)
                let button = UIButton()
                button.tag = index
                index += 1

                button.backgroundColor = .clear
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.systemGray6.cgColor
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

                gameView.addSubview(button)
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: gameView.topAnchor, constant: topOffset),
                    button.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: leadingOffset),
                    button.heightAnchor.constraint(equalToConstant: 15),
                    button.widthAnchor.constraint(equalToConstant: 15)
                ])
                buttons.append(button)

                leadingOffset += 15
                if leadingOffset >= 375 {
                    leadingOffset = 0
                }
            }
            topOffset += 15
        }
    }
    
    
}

extension View: GameStateDel {
    func presentGeneration() {
        genLabel.text = "\(gameView.grid.gen)"
    }
    
    func presentPopulation() {
        popLabel.text = "\(gameView.grid.pop)"
    }
    
    func updateGrid() {
        var i = 0
        for cell in gameView.grid.cellsInGrid {
            if cell.state == .alive {
                buttons[i].backgroundColor = buttonColor
            } else {
                buttons[i].backgroundColor = .clear
            }
            i = i + 1
        }
    }
    
    
}
