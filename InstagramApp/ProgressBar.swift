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
    private var widthSegment: CGFloat = 0.0
    private var padding: CGFloat = 3.0
    
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
    
    /*var isPaused: Bool = false {
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
    }*/
    
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
        self.widthSegment = width
        
        for (index, segment) in segments.enumerated() {
            let newFrame = CGRect(x: (width + padding) * CGFloat(index), y: 0, width: width, height: 6)
            segment.bottomView.frame = newFrame
            segment.bottomView.layer.cornerRadius = 3
        }
    }
    
    func getNextIndex() {
        let newIndex = self.currentIndex + 1
        if newIndex < segments.count {
            self.currentIndex = newIndex
            self.animate()
        }
    }
    
    func animate() {
        let newFrame = CGRect(x: (self.widthSegment + padding) * CGFloat(currentIndex), y: 0, width: 0, height: 6)
        let currentSegment = segments[currentIndex]
        currentSegment.topView.frame = newFrame
        currentSegment.topView.layer.cornerRadius = 3
        
        UIView.animate(withDuration: 5.0, delay: 0, options: .curveLinear, animations: {
            currentSegment.topView.frame.size.width = currentSegment.bottomView.frame.width
        }) { (finished) in
            if finished {
                self.getNextIndex()
            }
        }
    }
    
    func animation() {
        layoutSubviews()
        animate()
    }
    
    func skip() {
        let currentSegment = segments[currentIndex]
        currentSegment.topView.frame.size.width = currentSegment.bottomView.frame.width
        currentSegment.topView.layer.removeAllAnimations()
        self.getNextIndex()
    }
    
    func back() {
        let currentSegment = segments[currentIndex]
        currentSegment.topView.frame.size.width = 0
        currentSegment.topView.layer.removeAllAnimations()
        
        self.currentIndex = currentIndex-1 < 0 ? 0 : currentIndex-1
        let prevSegment = segments[currentIndex]
        prevSegment.topView.frame.size.width = 0
        self.animate()
        
    }
}

class Segment: UIView {
    let bottomView = UIView()
    let topView = UIView()
}