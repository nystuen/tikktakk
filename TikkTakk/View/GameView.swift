import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        GameCircle(proxy: geometry, indicator: viewModel.moves[i]?.indicator)
                        .onTapGesture {
                            viewModel.userDidTap(at: i)
                        }
                    }
                }
                Spacer()
            }
        }
        .disabled(viewModel.loading)
        .padding()
        .alert(item: $viewModel.alerItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle, action: {viewModel.resetGame()}))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
