import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let buttonTitle: Text
}

struct AlertContet {
    static let humanWin = AlertItem(title: Text("You win"), message: Text("Nice"), buttonTitle: Text("Ok"))
    static let computerWin = AlertItem(title: Text("Computer wins"), message: Text("Not nice"), buttonTitle: Text("Ok"))
    static let draw = AlertItem(title: Text("Game is draw"), message: Text("Ahh"), buttonTitle: Text("Ok"))
}
