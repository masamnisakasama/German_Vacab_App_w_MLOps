//
//  GrammarResultView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

struct GrammarResultView: View {
    let correctCount: Int
    let totalCount: Int
    let onBackToSettings: () -> Void

    var correctRate: Double {
        totalCount > 0 ? Double(correctCount) / Double(totalCount) : 0
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("文法クイズ結果")
                .font(.largeTitle)
                .bold()

            Text("正答数: \(correctCount) / \(totalCount)")
                .font(.title2)

            Text(String(format: "正答率: %.1f%%", correctRate * 100))
                .font(.title)
                .foregroundColor(correctRate >= 0.8 ? .green : .red)

            Spacer()

            Button("設定画面に戻る") {
                onBackToSettings()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    GrammarResultView(correctCount: 8, totalCount: 10, onBackToSettings: {})
}

