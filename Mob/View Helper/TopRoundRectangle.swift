//
//  TopRoundRectangle.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/12.
//

import SwiftUI

struct TopRoundedRectangle: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -180), endAngle: Angle(degrees: -90), clockwise: false)

        return path
    }
}

