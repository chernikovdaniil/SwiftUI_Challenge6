//
//  GeneralLayout.swift
//  SwiftUI_Challenge6
//
//  Created by Danil Chernikov on 16.12.2023.
//

import SwiftUI

struct GeneralLayout: Layout {
    @Binding var applyDiagonalLayout: Bool
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        if applyDiagonalLayout {
            makeDiagonalLayout(in: bounds, proposal: proposal, subviews: subviews)
        } else {
            makeHorizontalLayout(in: bounds, proposal: proposal, subviews: subviews)
        }
    }
    
    private func makeDiagonalLayout(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews) {
        let width = proposal.replacingUnspecifiedDimensions().width
        let height = proposal.replacingUnspecifiedDimensions().height
        
        let viewsCount = CGFloat(subviews.count)
        let viewHeight = height / viewsCount
        let viewSize = CGSize(width: viewHeight, height: viewHeight)
        
        var currentY = bounds.maxY
        var currentX = bounds.minX

        subviews.forEach {
            let position = CGPoint(x: currentX, y: currentY)
            $0.place(at: position, anchor: .bottomLeading, proposal: ProposedViewSize(viewSize))
            currentY -= viewHeight
            currentX += (width - viewHeight) / (viewsCount - 1)
        }
    }
    
    private func makeHorizontalLayout(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews) {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewsCount = Double(subviews.count)
        
        let spacingSum: CGFloat = 5 * viewsCount
        let viewWidth = (width - spacingSum) / viewsCount
        
        let viewSize = CGSize(width: viewWidth, height: viewWidth)
        
        var currentX = bounds.minX + viewWidth / 2

        subviews.forEach {
            let position = CGPoint(x: currentX, y: bounds.midY)
            
            $0.place(at: position, anchor: .center, proposal: ProposedViewSize(viewSize))
            
            currentX += viewWidth + spacingSum / (viewsCount - 1)
        }
    }
}
