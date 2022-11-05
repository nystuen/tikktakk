import SwiftUI

struct GameCircle: View {
    
    var proxy: GeometryProxy
    var indicator: String?
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.blue).opacity(0.5)
                .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
            Image(systemName: indicator ?? "")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
        }
    }
}
