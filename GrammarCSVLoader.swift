//
//  GrammarCSVLoade.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import SwiftUI

import Foundation

class GrammarCSVLoader {
    static func loadCSV(fileName: String) -> [GrammarQuizItem] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("CSVファイルが見つかりません")
            return []
        }

        do {
            let content = try String(contentsOfFile: path)
            let rows = content.components(separatedBy: "\n").dropFirst() // ヘッダー除去
            var items: [GrammarQuizItem] = []

            for row in rows {
                let columns = row.components(separatedBy: ",")
                if columns.count >= 7 {
                    let item = GrammarQuizItem(
                        question: columns[0],
                        options: Array(columns[1...4]),
                        correctAnswer: columns[5],
                        category: columns[6]
                    )
                    items.append(item)
                }
            }
            return items
        } catch {
            print("CSV読み込みエラー: \(error)")
            return []
        }
    }
}
