//
//  ProgressBar.swift
//  InstagramApp
//
//  Created by Natalia on 08.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation
import UIKit

class ProgressBar: UIView {
    private var segments = [Segment]()
    private var duration: TimeInterval = 5.0
    private var currentIndex = 0
    var padding: CGFloat = 3.0
    
    var bottomViewColor = UIColor.gray.withAlphaComponent(0.25) {
        didSet {
            self.updateColor()
        }
    }
    
    var topViewColor = UIColor.blue {
        didSet {
            self.updateColor()
        }
    }
    
    var isPaused: Bool = false {
        didSet {
            if isPaused {
                for segment in segments {
                    let layer = segment.topView.layer
                    let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
                    layer.speed = 0.0
                    layer.timeOffset = pausedTime
                }
            } else {
                let segment = segments[currentIndex]
                let layer = segment.topView.layer
                let pausedTime = layer.timeOffset
                layer.speed = 1.0
                layer.timeOffset = 0.0
                layer.beginTime = 0.0
                let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
                layer.beginTime = timeSincePause
            }
        }
    }
    
    init(countSegments: Int) {
        super.init(frame: .zero)
        
        for _ in 0...countSegments-1 {
            let segment = Segment()
            addSubview(segment.bottomView)
            addSubview(segment.topView)
            segments.append(segment)
        }
        
        self.updateColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateColor() {
        for segment in segments {
            segment.bottomView.backgroundColor = self.bottomViewColor
            segment.topView.backgroundColor = self.topViewColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = (frame.width - (CGFloat(segments.count - 1) * padding)) / CGFloat(segments.count)
        
        for (index, segment) in segments.enumerated() {
            let newFrame = CGRect(x: (width + padding) * CGFloat(index), y: 0, width: width, height: 6)
            segment.bottomView.frame = newFrame
            segment.topView.frame = newFrame
            segment.topView.frame.size.width = 0
        }
    }
    
    func getNextIndex() {
        let newIndex = self.currentIndex + 1
        if newIndex < segments.count {
            self.animate(index: newIndex)
        }
    }
    
    func animate(index: Int = 0) {
        let currentSegment = segments[index]
        currentSegment.topView.frame.size.width = 0
        self.currentIndex = index
        self.isPaused = false
        UIView.animate(withDuration: 5.0, delay: 0, options: .curveLinear, animations: {
            currentSegment.topView.frame.size.width = currentSegment.bottomView.frame.width
        }) { (finished) in
            if !finished {
                return
            }
            self.getNextIndex()
        }
    }
    
    func animation() {
        layoutSubviews()
        animate()
    }
}

class Segment: UIView {
    let bottomView = UIView()
    let topView = UIView()
}
