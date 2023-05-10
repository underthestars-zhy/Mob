//
//  MobbinScrollViewDelegate.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import UIKit

class MobbinScrollViewDelegate: NSObject, UIScrollViewDelegate, ObservableObject {
    @Published var isScrolling = false
    @Published var onBottom = 0

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isScrolling = false
    }

    func scrollViewDidEndScrolling(_ scrollView: UIScrollView) {
        isScrolling = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            onBottom += 1
        }
    }
}
