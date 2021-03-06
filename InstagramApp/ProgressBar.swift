//
//  ProgressBar.swift
//  InstagramApp
//
//  Created by Natalia on 08.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation
import UIKit

protocol ProgressBarDelegate {
    func changedIndex(index: Int)
}

class ProgressBar: UIView {
    var delegate: ProgressBarDelegate?
    private var segments = [Segment]()
    private var currentIndex = 0
    private var widthSegment: CGFloat = 0.0
    private var padding: CGFloat = 4.0
    private var duration = [TimeInterval]()
    private var topViewColor: UIColor!
    
    var isPaused: Bool = false {
        didSet {
            if isPaused {
                for segment in segments {
                    pause(view: segment.topView)
                }
            } else {
                resume(view: segments[currentIndex].topView)
            }
        }
    }
    
    init(countSegments: Int, duration: [TimeInterval], color: UIColor) {
        super.init(frame: .zero)
        
        self.duration = duration
        self.topViewColor = color
        
        for _ in 0..<countSegments {
            let segment = Segment()
            addSubview(segment.bottomView)
            addSubview(segment.topView)
            segments.append(segment)
        }
        
        for segment in segments {
            segment.bottomView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
            segment.topView.backgroundColor = topViewColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = (frame.width - (CGFloat(segments.count - 1) * padding)) / CGFloat(segments.count)
        widthSegment = width
        
        for (index, segment) in segments.enumerated() {
            let newFrame = CGRect(x: (width + padding) * CGFloat(index), y: 0, width: width, height: 3)
            segment.bottomView.frame = newFrame
            segment.bottomView.layer.cornerRadius = 5
            
            if index < currentIndex {
                let newTopFrame = CGRect(x: (width + padding) * CGFloat(index), y: 0, width: width, height: 3)
                segment.topView.frame = newTopFrame
            }
        }
    }
    
    func getNextIndex() {
        let newIndex = self.currentIndex + 1
        if newIndex < segments.count {
            currentIndex = newIndex
            animate()
            self.delegate?.changedIndex(index: newIndex)
        }
    }
    
    func animate() {
        let newFrame = CGRect(x: (self.widthSegment + padding) * CGFloat(currentIndex), y: 0, width: 0, height: 3)
        let currentSegment = segments[currentIndex]
        currentSegment.topView.frame = newFrame
        currentSegment.topView.layer.cornerRadius = 5
        isPaused = false
        
        UIView.animate(withDuration: duration[currentIndex], delay: 0, options: .curveLinear, animations: {
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
        getNextIndex()
    }
    
    func back() {
        let currentSegment = segments[currentIndex]
        currentSegment.topView.frame.size.width = 0
        currentSegment.topView.layer.removeAllAnimations()
        
        currentIndex = currentIndex-1 < 0 ? 0 : currentIndex-1
        let prevSegment = segments[currentIndex]
        prevSegment.topView.frame.size.width = 0
        animate()
        self.delegate?.changedIndex(index: currentIndex)
    }
    
    func deleteSegments() {
        for segment in segments {
            segment.topView.frame.size.width = 0
            segment.bottomView.frame.size.width = 0
        }
    }
    
    func addNewImage() {
        let segment = Segment()
        addSubview(segment.bottomView)
        addSubview(segment.topView)
        segment.bottomView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        segment.topView.backgroundColor = UIColor.blue
        segments.append(segment)
        
        currentIndex = currentIndex == 0 ? 0 : currentIndex - 1
        
        deleteSegments()
        
        animate()
    }
}

class Segment: UIView {
    let bottomView = UIView()
    let topView = UIView()
}

extension UIView {
    func resume(view: UIView) {
        let layer = view.layer
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    func pause(view: UIView) {
        let layer = view.layer
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
}
