import SwiftUI
import GameKit

struct GameOverView: View {
    let score: UInt
    let onSubmitScore: () -> Void
    var onViewLeaderboard: () -> Void
    var onPlayAgain: () -> Void
    @State private var showingSubmitSuccess = false
    @State private var showingSubmitError = false
    @State private var errorMessage = ""
    
    private let buttonTextColor = Color(hex: "D5BF9D")
   
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Image("GameOver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                
                Text("Final Score: \(score)")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(buttonTextColor)
                
                VStack(spacing: 15) {
                    Button(action: {
                        GameCenterManager.shared.submitScore(Int(score)) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                                showingSubmitError = true
                            } else {
                                showingSubmitSuccess = true
                            }
                        }
                    }) {
                        Text("Submit High Score")
                            .font(.headline)
                            .foregroundColor(buttonTextColor)
                            .frame(width: 240, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: onViewLeaderboard) {
                        Text("View Leaderboard")
                            .font(.headline)
                            .foregroundColor(buttonTextColor)
                            .frame(width: 240, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: onPlayAgain) {
                        Text("Play Again")
                            .font(.headline)
                            .foregroundColor(buttonTextColor)
                            .frame(width: 240, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .alert("Score Submitted!", isPresented: $showingSubmitSuccess) {
            Button("OK", role: .cancel) { }
        }
        .alert("Error", isPresented: $showingSubmitError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
} 
