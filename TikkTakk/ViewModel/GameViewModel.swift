import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var loading: Bool = false
    @Published var gameIsOver: Bool = false
    @Published var alerItem: AlertItem?
    
    func userDidTap(at index: Int) {
        guard !gameIsOver, moves[index] == nil else { return }
        
        moves[index] = Move(player: .human, boardIndex: index)
         
        gameIsOver = determineGaveIsOver(in: moves)
        if(gameIsOver) { return }
        loading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now () + Double.random(in: 0.5..<1)) { [self] in
            let computerMove = determineComputerMovePosition(in: moves)
            moves[computerMove] = Move(player: .computer, boardIndex: computerMove)
            loading = false
            gameIsOver = determineGaveIsOver(in: moves)
        }
    }
    
    func determineGaveIsOver(in moves: [Move?]) -> Bool {
        if checkWinCondition(for: .human, in: moves) {
            alerItem = AlertContet.humanWin
            return true
        } else if checkWinCondition(for: .computer, in: moves) {
            alerItem = AlertContet.computerWin
            return true
        } else if checkForDraw(in: moves) {
            alerItem = AlertContet.draw
            return true
        }
        return false
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let playerMoves = moves.compactMap{ $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
            
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
         let movePosition = Int.random(in: 0..<9)
        guard moves[movePosition] == nil else { return  determineComputerMovePosition(in: moves) }
        return movePosition
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        gameIsOver = false
    }
}
