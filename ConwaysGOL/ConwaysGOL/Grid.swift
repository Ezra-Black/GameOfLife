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
        self.examples(pattern: .random)
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
    
    func CellCoordinates(index: Int) -> (x: Int, y: Int) {
        var x = 0
        var y = 0
        y = index / size
        x = index - (y * size)
        return (x, y)
    }
    
    func cycleGeneration() {
        var index = 0
        var kill: [Cell] = []
        var birth: [Cell] = []
        
        for cell in cellsInGrid {
            var count = 0
            let coord = CellCoordinates(index: index)
            //W
            if coord.x != 0 { if cellAt(x: coord.x - 1, y: coord.y).state == .alive { count = count + 1 }}
            //NW
            if coord.x != 0 && coord.y != 0 { if cellAt(x: coord.x - 1, y: coord.y - 1).state == .alive { count = count + 1 }}
            //N
            if coord.y != 0 { if cellAt(x: coord.x, y: coord.y - 1).state == .alive {count = count + 1}}
            //NE
            if coord.x < (size - 1) && coord.y != 0 { if cellAt(x: coord.x + 1, y: coord.y - 1).state == .alive { count = count + 1 }}
            //E
            if coord.x < (size - 1) { if cellAt(x: coord.x + 1, y: coord.y).state == .alive { count = count + 1 }}
            //SE
            if coord.x < (size - 1) && coord.y < (size - 1) { if cellAt(x: coord.x + 1, y: coord.y + 1).state == .alive { count = count + 1 }}
            // S
            if coord.y < (size - 1) { if cellAt(x: coord.x, y: coord.y + 1).state == .alive { count = count + 1 }}
            // SW
            if coord.x != 0 && coord.y < (size - 1) { if cellAt(x: coord.x - 1, y: coord.y + 1).state == .alive { count = count + 1 }}
            
            if cell.state == .alive {
                if count < 2 || count > 3 {
                    kill.append(cell)
                }
            } else { // cell.state == .dead
                if count == 3 {
                    birth.append(cell)
                }
            }
            index = index + 1
        }
        
        for cell in kill { cell.state = .dead }
        
        for cell in birth { cell.state = .alive }
        gen += 1
        callDelegate()
    }
    
    func clearGrid() {
        for cell in cellsInGrid {
            cell.state = .dead
        }
        gen = 0
        callDelegate()
    }
    
    private func callDelegate() {
        delegate?.presentGeneration()
        delegate?.presentPopulation()
        delegate?.updateGrid()
    }
    
    private func randomize() {
        for cell in cellsInGrid {
            let randomState = Int.random(in: 0...6)
            cell.state = randomState == 0 ? .alive : .dead
        }
    }
    
    public enum Patterns {
        case random
        case blinker
        case glider
        case pulsar
    }
    
    public func examples(pattern: Patterns = .glider) {
        print(pattern)
        clearGrid()
        switch pattern {
        case .random:
            randomize()
        case .blinker:
            cellAt(x: 3, y: 2).state = .alive
            cellAt(x: 4, y: 2).state = .alive
            cellAt(x: 5, y: 2).state = .alive
        case .glider:
            cellAt(x: 3, y: 2).state = .alive
            cellAt(x: 4, y: 3).state = .alive
            cellAt(x: 4, y: 4).state = .alive
            cellAt(x: 3, y: 4).state = .alive
            cellAt(x: 2, y: 4).state = .alive
        case .pulsar:
            cellAt(x: 6, y: 2).state = .alive
            cellAt(x: 6, y: 3).state = .alive
            cellAt(x: 6, y: 4).state = .alive
            cellAt(x: 7, y: 4).state = .alive
            cellAt(x: 12, y: 2).state = .alive
            cellAt(x: 12, y: 3).state = .alive
            cellAt(x: 12, y: 4).state = .alive
            cellAt(x: 11, y: 4).state = .alive
            cellAt(x: 2, y: 6).state = .alive
            cellAt(x: 3, y: 6).state = .alive
            cellAt(x: 4, y: 6).state = .alive
            cellAt(x: 4, y: 7).state = .alive
            cellAt(x: 7, y: 6).state = .alive
            cellAt(x: 8, y: 6).state = .alive
            cellAt(x: 8, y: 7).state = .alive
            cellAt(x: 6, y: 7).state = .alive
            cellAt(x: 6, y: 8).state = .alive
            cellAt(x: 7, y: 8).state = .alive
            cellAt(x: 10, y: 6).state = .alive
            cellAt(x: 11, y: 6).state = .alive
            cellAt(x: 10, y: 7).state = .alive
            cellAt(x: 12, y: 7).state = .alive
            cellAt(x: 11, y: 8).state = .alive
            cellAt(x: 12, y: 8).state = .alive
            cellAt(x: 14, y: 6).state = .alive
            cellAt(x: 15, y: 6).state = .alive
            cellAt(x: 16, y: 6).state = .alive
            cellAt(x: 14, y: 7).state = .alive
            cellAt(x: 2, y: 12).state = .alive
            cellAt(x: 3, y: 12).state = .alive
            cellAt(x: 4, y: 12).state = .alive
            cellAt(x: 4, y: 11).state = .alive
            cellAt(x: 6, y: 10).state = .alive
            cellAt(x: 7, y: 10).state = .alive
            cellAt(x: 6, y: 11).state = .alive
            cellAt(x: 8, y: 11).state = .alive
            cellAt(x: 7, y: 12).state = .alive
            cellAt(x: 8, y: 12).state = .alive
            cellAt(x: 11, y: 10).state = .alive
            cellAt(x: 12, y: 10).state = .alive
            cellAt(x: 12, y: 11).state = .alive
            cellAt(x: 10, y: 11).state = .alive
            cellAt(x: 10, y: 12).state = .alive
            cellAt(x: 11, y: 12).state = .alive
            cellAt(x: 14, y: 11).state = .alive
            cellAt(x: 14, y: 12).state = .alive
            cellAt(x: 15, y: 12).state = .alive
            cellAt(x: 16, y: 12).state = .alive
            cellAt(x: 6, y: 14).state = .alive
            cellAt(x: 6, y: 15).state = .alive
            cellAt(x: 6, y: 16).state = .alive
            cellAt(x: 7, y: 14).state = .alive
            cellAt(x: 12, y: 14).state = .alive
            cellAt(x: 12, y: 15).state = .alive
            cellAt(x: 12, y: 16).state = .alive
            cellAt(x: 11, y: 14).state = .alive
        }
        gen = 0
        callDelegate()
    }
}
