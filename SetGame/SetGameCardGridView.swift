//
//  SetGameCardGrid.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct SetGameCardGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: Array<Item>
    private var viewForItem: (Item) -> ItemView
    
    private func getColumns(itemCount: Int, in size: CGSize) -> [GridItem]  {
        // find the bestLayout
        // i.e., one which results in cells whose aspectRatio
        // has the smallestVariance from desiredAspectRatio
        // not necessarily most optimal code to do this, but easy to follow (hopefully)
        var bestCols = 1
        var smallestVariance: Double?
        let desiredAspectRatio: Double = abs(Double(size.width/size.height))
        for cols in 1...itemCount {
            let rows = (itemCount / cols) + (itemCount % cols > 0 ? 1 : 0)
            if (rows - 1) * cols < itemCount {
                let itemAspectRatio = (5/6) * (Double(cols)/Double(rows))
                let variance = itemAspectRatio - desiredAspectRatio
                if smallestVariance == nil || variance < smallestVariance! {
                    if variance > 0 {
                        smallestVariance = variance
                        bestCols = cols
                    }
                }
            }
        }
        return Array(repeating: GridItem(.flexible()), count: bestCols)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: getColumns(itemCount: items.count, in: geometry.size), spacing: 10) {
                    ForEach(items) { item in
                        viewForItem(item)
                    }
                }
                Spacer()
            }.padding()
        }
    }
}
