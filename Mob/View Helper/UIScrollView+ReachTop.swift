//
//  UIScrollView+ReachTop.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/15.
//

import UIKit

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
