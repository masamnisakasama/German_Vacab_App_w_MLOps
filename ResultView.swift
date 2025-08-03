//
//  ResultView.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

struct ResultView: View {
    let correctCount: Int
    let totalCount: Int
    let onBackToSetting: () -> Void

    var correctRate: Double {
        totalCount == 0 ? 0 : Double(correctCount) / Double(totalCount)
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("学習結果")
                .font(.largeTitle)

            Text("正答数: \(correctCount) / \(totalCount)")
                .font(.title2)

            Text(String(format: "正答率: %.1f%%", correctRate * 100))
                .font(.title)
                .foregroundColor(correctRate >= 0.8 ? .green : .red)

            Spacer()

            Button("学習設定に戻る") {
                onBackToSetting()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}


#Preview {
    ResultView(correctCount: 10, totalCount: 20, onBackToSetting: {
        print("戻るボタンが押されました")
    })
}
