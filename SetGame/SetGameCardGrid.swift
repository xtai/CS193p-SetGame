//
//  SetGameCardGrid.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//

import SwiftUI

struct SetGameCardGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: Array<Item>
    private var itemRatio: CGFloat
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], itemRatio: CGFloat, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
        self.itemRatio = itemRatio
    }
    
    private func getColumns(itemCount: Int, itemAspectRatio: CGFloat, in size: CGSize) -> [GridItem]  {
        // find the best colunm count in LazyVGrid that fits all the cards
        var bestCols = 1
        var smallestVariance: Double?
        let desiredAspectRatio: Double = abs(Double(size.width/size.height))
        if itemCount > 0 {
            for cols in 1...itemCount {
                let rows = (itemCount / cols) + (itemCount % cols > 0 ? 1 : 0)
                if (rows - 1) * cols < itemCount {
                    // this ignores the grid padding, but hopefullt it's okay
                    let gridAspectRatio = Double(itemAspectRatio) * (Double(cols)/Double(rows))
                    let variance = gridAspectRatio - desiredAspectRatio
                    if smallestVariance == nil || variance < smallestVariance! {
                        if variance > 0 {
                            smallestVariance = variance
                            bestCols = cols
                        }
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
                LazyVGrid(columns: getColumns(itemCount: items.count, itemAspectRatio: itemRatio, in: geometry.size), spacing: 0) {
                    ForEach(items, id: \.id) { item in
                        viewForItem(item)
                            .padding(.bottom, 10)
                    }
                }
                Spacer()
            }
        }.padding(10)
    }
}
