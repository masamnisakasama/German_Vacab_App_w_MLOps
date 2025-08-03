//
//  GrammarMultipleChoiceQuizView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import AVFoundation
import SwiftUI

struct GrammarMultipleChoiceQuizView: View {
    let limit: Int
    let onFinish: (Int, Int) -> Void

    @State private var quizItems: [GrammarQuizItem] = []
    @State private var currentIndex = 0
    @State private var correctCount = 0
    @State private var showResult = false

    @State private var selectedAnswer: String? = nil
    @State private var isAnswerCorrect: Bool? = nil

    // サウンドプレイヤー（遅延初期化）
    @State private var correctSound: AVAudioPlayer?
    @State private var wrongSound: AVAudioPlayer?

    var body: some View {
        VStack(spacing: 24) {
            if currentIndex < quizItems.count {
                let current = quizItems[currentIndex]

                Text(current.question)
                    .font(.title2)
                    .bold()

                ForEach(current.options, id: \.self) { option in
                    Button(action: {
                        guard selectedAnswer == nil else { return }

                        selectedAnswer = option
                        isAnswerCorrect = (option == current.correctAnswer)
                        if isAnswerCorrect == true {
                            correctCount += 1
                            playSound(isCorrect: true)
                        } else {
                            playSound(isCorrect: false)
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            nextQuestion()
                            selectedAnswer = nil
                            isAnswerCorrect = nil
                        }
                    }) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgroundColor(option: option, correctAnswer: current.correctAnswer))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(selectedAnswer != nil)
                }
            } else {
                EmptyView()
            }
        }
        .padding()
        .onAppear {
            let allItems = GrammarCSVLoader.loadCSV(fileName: "grammar_quiz")
            quizItems = Array(allItems.shuffled().prefix(limit))
            prepareSounds()
        }
        .fullScreenCover(isPresented: $showResult) {
            GrammarResultView(correctCount: correctCount, totalCount: quizItems.count) {
                onFinish(correctCount, quizItems.count)
            }
        }
    }

    private func buttonBackgroundColor(option: String, correctAnswer: String) -> Color {
        guard let selected = selectedAnswer else {
            return .blue
        }

        if option == selected {
            // 押した選択肢
            return isAnswerCorrect == true ? .green : .red
        }

        if isAnswerCorrect == false && option == correctAnswer {
            // 間違えた時に正解を緑に表示
            return .green
        }

        // その他は薄いグレーに
        return .gray.opacity(0.4)
    }

    private func nextQuestion() {
        if currentIndex < quizItems.count - 1 {
            currentIndex += 1
        } else {
            showResult = true
        }
    }

    private func playSound(isCorrect: Bool) {
        if isCorrect {
            correctSound?.play()
        } else {
            wrongSound?.play()
        }
    }

    private func prepareSounds() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSession error: \(error)")
        }
        
        if let correctURL = Bundle.main.url(forResource: "correct", withExtension: "mp3"),
           let wrongURL = Bundle.main.url(forResource: "wrong", withExtension: "mp3") {
            correctSound = try? AVAudioPlayer(contentsOf: correctURL)
            wrongSound = try? AVAudioPlayer(contentsOf: wrongURL)
        }
    
    }
}
