//
//  Grid.swift
//  ConwaysGOL
//
//  Created by Ezra Black on 7/27/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation

// TODO: Game Stats/ Game Grid/ Grid Functionality/ Delegation
protocol GameStateDel {
    func presentGeneration()
    func presentPopulation()
    func updateGrid()
}

//game grid class

class Grid: NSObject {
    let size: Int
    var cellsInGrid: [Cell] = []
    var delegate: GameStateDel?

    var gen = 0
    var pop: Int { cellsInGrid.filter { $0.state == .alive }.count }

    public init(gridSize: Int) {
        self.size = gridSize
        for y in 0..<size {
            for x in 0..<size {
                let cell = Cell(x: x, y: y)
                cellsInGrid.append(cell)
            }
        }
        super.init()
    }
    
    func cellTapped(at index: Int) {
        if cellsInGrid[index].state == .alive {
            cellsInGrid[index].state = .dead
        } else { cellsInGrid[index].state = .alive
            
        }
        callDelegate()
    }
    
    func cellAt(x: Int, y: Int) -> Cell {
        var position: Int
        position = (y * size) + x
        return cellsInGrid[position]
    }
    
    private func callDelegate() {
        
    }
}


//game lifecycle



//game state functionality/ clearing screen/ updating patterns
