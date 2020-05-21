//
//  ViewController.swift
//  InstagramApp
//
//  Created by Natalia on 08.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProgressBarDelegate {
    func changedIndex(index: Int) {
        showSnap(index: index)
    }
    
    var imageView: UIImageView!
    var contextView: UIView!
    private var progressBar: ProgressBar!
    var buttonArray = [ButtonModel]()
    var snapArray = [SnapModel]()
    var durationArray = [TimeInterval]()
    var currentHeight: CGFloat = 24
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        contextView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.addSubview(contextView)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        contextView.addSubview(imageView)
        
        let recognizerLongPress = UILongPressGestureRecognizer(target: self, action: #selector(paused(_:)))
        view.addGestureRecognizer(recognizerLongPress)
        
        let recognizerTap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        view.addGestureRecognizer(recognizerTap)
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "center", image: "img1", theme: "", duration: 5.0, color: "white", alignmentButton: "center", colorButton: "black", backgroundButton: "white", textButton: "Большая кнопка", action: "", sizeTextButton: 20)
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "left", image: "img2", theme: "", duration: 10.0, color: "white", alignmentButton: "left", colorButton: "black", backgroundButton: "white", textButton: "Большая кнопка", action: "", sizeTextButton: 20)
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "right", image: "img3", theme: "", duration: 1.0, color: "white", alignmentButton: "right", colorButton: "black", backgroundButton: "white", textButton: "Большая кнопка", action: "", sizeTextButton: 20)
        
        showSnap(index: 0)
    
        progressBar = ProgressBar(countSegments: snapArray.count, duration: durationArray)
        progressBar.delegate = self
        progressBar.frame = CGRect(x: 15, y: 50, width: view.frame.width - 30, height: 6)
        
        view.addSubview(progressBar)
        
        progressBar.animation()
    }
    
    func createSnap(textSnap: String?,
                    subtextSnap: String?,
                    sizeTextSnap: Int,
                    sizeSubtextSnap: Int,
                    alignmentSnap: String,
                    image: String?,
                    theme: String,
                    duration: TimeInterval,
                    color: String,
                    alignmentButton: String,
                    colorButton: String,
                    backgroundButton: String,
                    textButton: String?,
                    action: String,
                    sizeTextButton: Int) {
        let button = ButtonModel(alignment: alignmentButton, color: colorButton, background: backgroundButton, text: textButton, action: action, sizeText: sizeTextButton)
        let snap = SnapModel(text: textSnap, subtext: subtextSnap, sizeText: sizeTextSnap, sizeSubtext: sizeSubtextSnap, alignment: alignmentSnap, image: image, theme: theme, duration: duration, button: button, color: color)
        
        buttonArray.append(button)
        snapArray.append(snap)
        durationArray.append(duration)
    }
    
    func showSnap(index: Int) {
        deleteAllSubviews()
        builder(snap: snapArray[index], button: buttonArray[index])
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x < UIScreen.main.bounds.width / 3 {
            progressBar.back()
        } else {
            progressBar.skip()
        }
    }
    
    @objc func paused(_ sender: UILongPressGestureRecognizer) {
        progressBar.isPaused = !progressBar.isPaused
    }
    
    /*func textToImage(text: NSString, image: UIImage, point: CGPoint) {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 80)!
        let paragrapheStyle = NSMutableParagraphStyle()
        paragrapheStyle.alignment = .center
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let attributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.paragraphStyle: paragrapheStyle
            ] as [NSAttributedStringKey : Any]
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let rect = CGRect(x: point.x, y: point.y, width: image.size.width, height: image.size.height)
        
        text.draw(in: rect, withAttributes: attributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView.image = newImage
    }*/
    
    func createLabelText(text: String,
                     sizeText: Int,
                     alignment: String,
                     color: UIColor) {
        let labelText = UILabel()
        labelText.text = text
        labelText.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeText))!
        labelText.textColor = color
        labelText.lineBreakMode = .byWordWrapping
        labelText.numberOfLines = 0
        
        switch alignment {
            case "left":
                labelText.textAlignment = .left
            case "right":
                labelText.textAlignment = .right
            case "center":
                labelText.textAlignment = .center
            default:
            break
        }
     
        let sizeLabelText = labelText.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 48, height: CGFloat.greatestFiniteMagnitude))
     
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (currentHeight + sizeLabelText.height))
        
        currentHeight += sizeLabelText.height
     
        labelText.frame = CGRect(origin: point, size: sizeLabelText)
     
        contextView.addSubview(labelText)
    }
    
    func createLabelSubtext(subtext: String,
                            sizeSubtext: Int,
                            alignment: String,
                            color: UIColor) {
        let labelSubtext = UILabel()
        labelSubtext.text = subtext
        labelSubtext.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeSubtext))!
        labelSubtext.textColor = color
        labelSubtext.lineBreakMode = .byWordWrapping
        labelSubtext.numberOfLines = 0
        
        switch alignment {
        case "left":
            labelSubtext.textAlignment = .left
        case "right":
            labelSubtext.textAlignment = .right
        case "center":
            labelSubtext.textAlignment = .center
        default:
            break
        }
        
        let sizeLabelSubtext = labelSubtext.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 48, height: CGFloat.greatestFiniteMagnitude))
        
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (currentHeight + sizeLabelSubtext.height))
        
        currentHeight += sizeLabelSubtext.height + 24
        
        labelSubtext.frame = CGRect(origin: point, size: sizeLabelSubtext)
        
        contextView.addSubview(labelSubtext)
    }
    
    func createButton(type: UIButtonType,
                      text: String,
                      sizeText: Int,
                      alignment: String,
                      background: UIColor,
                      color: UIColor) {
        let newButton = UIButton(type: type)
        newButton.backgroundColor = background
        newButton.setTitle(text, for: .normal)
        newButton.setTitleColor(color, for: .normal)
        newButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeText))!
        newButton.titleLabel?.textAlignment = .center
        
        let sizeButton = newButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        var point = CGPoint()
        
        switch alignment {
        case "left":
            point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (currentHeight + sizeButton.height))
        case "right":
            point = CGPoint(x: UIScreen.main.bounds.width - (24 + sizeButton.width), y: UIScreen.main.bounds.height - (currentHeight + sizeButton.height))
        case "center":
            point = CGPoint(x: (UIScreen.main.bounds.width - sizeButton.width) / 2, y: UIScreen.main.bounds.height - (currentHeight + sizeButton.height))
        default:
            break
        }
        
        currentHeight += sizeButton.height + 24
        
        newButton.frame = CGRect(origin: point, size: sizeButton)
        
        contextView.addSubview(newButton)
    }
    
    func deleteAllSubviews() {
        contextView.subviews.forEach({ $0.removeFromSuperview() })
        contextView.addSubview(imageView)
        currentHeight = 24
    }
    
    func builder(snap: SnapModel, button: ButtonModel) {
        if let image = snap.image {
            imageView.image = UIImage(named: image)
        }
        
        if let text = button.text {
            createButton(type: .custom, text: text, sizeText: button.sizeText, alignment: button.alignment, background: UIColor(named: button.background)!, color: UIColor(named: button.color)!)
        }
        
        if let subtext = snap.subtext {
            createLabelSubtext(subtext: subtext, sizeSubtext: snap.sizeSubtext, alignment: snap.alignment, color: UIColor(named: snap.color)!)
        }
        
        if let text = snap.text {
            createLabelText(text: text, sizeText: snap.sizeText, alignment: snap.alignment, color: UIColor(named: snap.color)!)
        }
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

