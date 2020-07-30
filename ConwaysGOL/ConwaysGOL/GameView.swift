//
//  GameView.swift
//  ConwaysGOL
//
//  Created by Ezra Black on 7/27/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    
    //MARK: Properties
    var grid = Grid(gridSize: 25)
    private var sizeOfCell: Int = 15
    
    private var timer: Timer?
    var timeInterval = 0.25
    var timerRunning: Bool { timer == nil ? false : true}
    public convenience init(gridS: Int, cellS: Int) {
        let frame = CGRect(x: 0, y: 0, width: cellS * gridS, height: cellS * gridS)
        self.init(frame: frame)
        self.grid = Grid(gridSize: gridS)
        self.sizeOfCell = cellS
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    public func cancelTime() {
        timer?.invalidate()
        timer = nil
    }
    
    public func tappedCell(at index: Int) {
        grid.cellTapped(at: index)
    }
    
    public func gridClear() {
        grid.clearGrid()
        setNeedsDisplay()
    }
    
    public func timerStart() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
        target: self,
        selector: #selector(cycleGameTurn),
        userInfo: nil,
        repeats: true)
    }
    
    @objc private func cycleGameTurn() {
        self.grid.cycleGeneration()
        self.setNeedsDisplay()
    }
    
    //One iteration over a generation, step by step mode.
    public func step() {
        grid.cycleGeneration()
        setNeedsDisplay()
    }
    //clears grid and implements basic shapes known to most devs in the community/famous shapes such as ships.
    public func Patterns(pattern: Patterns) {
        grid.clearGrid()
        grid.examples(pattern: pattern)
    }
}
