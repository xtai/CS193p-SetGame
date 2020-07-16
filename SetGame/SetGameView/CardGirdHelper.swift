//
//  CardGirdHelper.swift
//  SetGame
//
//  Created by Sean Tai on 7/11/20.
//
//  Creating a card grid with LazyVGrid

import SwiftUI

struct CardGirdHelper<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: Array<Item>
    private var itemRatio: CGFloat
    private var itemsCount: Int
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], itemsCount: Int, itemRatio: CGFloat, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.itemsCount = itemsCount
        self.viewForItem = viewForItem
        self.itemRatio = itemRatio
    }
    
    private func getColumns(itemCount: Int, itemAspectRatio: CGFloat, in size: CGSize) -> (cols: [GridItem], deltaHeight: CGFloat)  {
        // find the best colunm count in LazyVGrid that fits all the cards
        var bestCols: Int = 1
        var deltaHeight: CGFloat = 0.0
        if itemCount > 0 {
            for cols in 3...itemCount {
                let rows = (itemCount / cols) + (itemCount % cols > 0 ? 1 : 0)
                let cardHeight = (size.width - CGFloat((cols - 1)) * vSpacing) / (CGFloat(cols) * itemAspectRatio)
                let areaHeight = ((cardHeight + HSpacing) * CGFloat(rows) - 7)
                if (areaHeight < size.height) {
                    bestCols = cols
                    deltaHeight = (size.height - areaHeight) / 2
                    break
                }
            }
        }
        return (cols: Array(repeating: GridItem(.flexible()), count: bestCols), deltaHeight: deltaHeight)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Rectangle()
                    .opacity(0)
                    .frame(width: geometry.size.width, height: getColumns(itemCount: itemsCount, itemAspectRatio: itemRatio, in: geometry.size).deltaHeight, alignment: .top)
                    .animation(Animation.easeInOut(duration: 1.0).delay(1.0))
                LazyVGrid(columns: getColumns(itemCount: itemsCount, itemAspectRatio: itemRatio, in: geometry.size).cols, spacing: HSpacing) {
                    ForEach(items, id: \.id) { item in
                        viewForItem(item)
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }
        }
    }
    
    // MARK: - Drawing Constants
    private let HSpacing: CGFloat = 8.0
    private let vSpacing: CGFloat = 8.0
}
