//
//  CSVLoader.swift
//  Vocab_app_w_MLOPs
//
//  Created by 池田まさひろ on 2025/08/01.
//

import Foundation

class CSVLoader {
    static func loadCSV(fileName: String) -> [WordItem] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("ファイルが見つかりません")
            return []
        }

        do {
            let data = try String(contentsOfFile: path)
            let rows = data.components(separatedBy: "\n").dropFirst() // ヘッダー除外
            var wordItems: [WordItem] = []

            for row in rows {
                let columns = row.components(separatedBy: ",")
                if columns.count >= 7 {
                    let item = WordItem(
                        word: columns[0],
                        plural: columns[1],
                        meaning: columns[2],
                        example: columns[3],
                        exampleJa: columns[4],
                        note: columns[5],
                        category: columns[6]
                    )
                    wordItems.append(item)
                }
            }
            return wordItems
        } catch {
            print("CSV読み込みエラー: \(error)")
            return []
        }
    }
}
