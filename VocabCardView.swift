//
//  VocabCardView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//



import SwiftUI

struct VocabCardView: View {
    let limit: Int
    let level: String
    let onFinish: (Int, Int) -> Void
    let onBackToSetting: () -> Void

    @State private var wordItems: [WordItem] = []
    @State private var currentIndex = 0
    @State private var correctCount = 0
    @State private var showResult = false

    var body: some View {
        VStack(spacing: 24) {
            NavigationLink(destination:
                ResultView(
                    correctCount: correctCount,
                    totalCount: wordItems.count,
                    onBackToSetting: onBackToSetting
                ),
                isActive: $showResult
            ) {
                EmptyView()
            }
            .hidden()

            if currentIndex < wordItems.count {
                let current = wordItems[currentIndex]

                Text(current.word)
                    .font(.largeTitle)

                Text(current.meaning)
                    .foregroundColor(.gray)

                VStack {
                    Text(current.example)
                    Text(current.exampleJa)
                        .foregroundColor(.secondary)
                }
                .padding()

                HStack(spacing: 20) {
                    Button("不正解") {
                        next()
                    }
                    .frame(width: 120, height: 44)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("正解") {
                        correctCount += 1
                        next()
                    }
                    .frame(width: 120, height: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            } else {
                Text("読み込み中...")
            }
        }
        .padding()
        .onAppear {
            let allItems = CSVLoader.loadCSV(fileName: "words")
            let filtered = allItems.filter { $0.category == level }
            wordItems = Array(filtered.shuffled().prefix(limit))
        }
    }

    private func next() {
        if currentIndex < wordItems.count - 1 {
            currentIndex += 1
        } else {
            showResult = true
        }
    }
}

#Preview {
    VocabCardView(
        limit: 10,
        level: "A1",
        onFinish: { correct, total in
            print("終了: \(correct)/\(total)")
        },
        onBackToSetting: {
            print("設定画面へ戻る")
        }
    )
}
