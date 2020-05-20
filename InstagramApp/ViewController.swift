//
//  ViewController.swift
//  InstagramApp
//
//  Created by Natalia on 08.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProgressBarDeligate {
    func changedIndex(index: Int) {
        showSnap(index: index)
    }
    

    @IBOutlet weak var imageView: UIImageView!
    //var imageView: UIImageView!
    private var progressBar: ProgressBar!
    var buttonArray = [ButtonModel]()
    var snapArray = [SnapModel]()
    var durationArray = [TimeInterval]()
    var sizeButton: CGSize = CGSize(width: 0, height: 0)
    var sizeLabelText: CGSize = CGSize(width: 0, height: 0)
    var sizeLabelSubtext: CGSize = CGSize(width: 0, height: 0)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        /*imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imageView.backgroundColor = UIColor.white
        view.addSubview(imageView)
        
        let recognizerLongPress = UILongPressGestureRecognizer(target: self, action: #selector(paused(_:)))
        view.addGestureRecognizer(recognizerLongPress)
        
        let recognizerTap = UITapGestureRecognizer()
        
        var locationTap = recognizerTap.location(in: view) {
            didSet {
                if locationTap.x < UIScreen.main.bounds.width / 2
                {
                    recognizerTap.addTarget(self, action: #selector(back(_:)))
                } else {
                    recognizerTap.addTarget(self, action: #selector(skip(_:)))
                }
            }
        }
        
        view.addGestureRecognizer(recognizerTap)*/
        
        imageView.contentMode = .scaleAspectFill
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "center", image: "img1", theme: "", duration: 5.0, alignmentButton: "center", colorButton: "black", backgroundButton: "white", textButton: "Большая кнопка", action: "", sizeTextButton: 20)
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "left", image: "img2", theme: "", duration: 10.0, alignmentButton: "left", colorButton: "black", backgroundButton: "white", textButton: "Большая кнопка", action: "", sizeTextButton: 20)
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "right", image: "img3", theme: "", duration: 1.0, alignmentButton: "right", colorButton: "black", backgroundButton: "white", textButton: "Большая кнопка", action: "", sizeTextButton: 20)
        
        builder(snap: snapArray[1], button: buttonArray[1])
    
        progressBar = ProgressBar(countSegments: 3, duration: durationArray)
        progressBar.deligate = self
        progressBar.frame = CGRect(x: 15, y: 50, width: view.frame.width - 30, height: 6)
        
        view.addSubview(progressBar)
        
        progressBar.animation()
    }
    
    func createSnap(textSnap: NSString?,
                    subtextSnap: NSString?,
                    sizeTextSnap: NSInteger,
                    sizeSubtextSnap: NSInteger,
                    alignmentSnap: NSString,
                    image: NSString?,
                    theme: NSString,
                    duration: TimeInterval,
                    alignmentButton: NSString,
                    colorButton: NSString,
                    backgroundButton: NSString,
                    textButton: NSString,
                    action: NSString,
                    sizeTextButton: NSInteger) {
        let button = ButtonModel(alignment: alignmentButton, color: colorButton, background: backgroundButton, text: textButton, action: action, sizeText: sizeTextButton)
        let snap = SnapModel(text: textSnap, subtext: subtextSnap, sizeText: sizeTextSnap, sizeSubtext: sizeSubtextSnap, alignment: alignmentSnap, image: image, theme: theme, duration: duration, button: button)
        
        buttonArray.append(button)
        snapArray.append(snap)
        durationArray.append(duration)
    }
    
    func showSnap(index: Int) {
        //builder(snap: snapArray[index], button: buttonArray[index])
    }

    @objc func skip(_ sender: UITapGestureRecognizer) {
        progressBar.skip()
    }
    
    @objc func back(_ sender: UITapGestureRecognizer) {
        progressBar.back()
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
    
    func createLabelText(text: NSString,
                     sizeText: NSInteger,
                     alignment: NSString,
                     color: UIColor) {
        let labelText = UILabel()
        labelText.text = text as String
        labelText.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeText))!
        labelText.textColor = color
        labelText.lineBreakMode = .byWordWrapping
        labelText.numberOfLines = 0
        
        switch alignment as String {
            case "left":
                labelText.textAlignment = .left
            case "right":
                labelText.textAlignment = .right
            case "center":
                labelText.textAlignment = .center
            default:
            break
        }
     
        sizeLabelText = labelText.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 48, height: CGFloat.greatestFiniteMagnitude))
     
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - 72 - sizeLabelSubtext.height - sizeLabelText.height - sizeButton.height)
     
        labelText.frame = CGRect(origin: point, size: sizeLabelText)
     
        view.addSubview(labelText)
    }
    
    func createLabelSubtext(subtext: NSString,
                            sizeSubtext: NSInteger,
                            alignment: NSString,
                            color: UIColor) {
        let labelSubtext = UILabel()
        labelSubtext.text = subtext as String
        labelSubtext.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeSubtext))!
        labelSubtext.textColor = color
        labelSubtext.lineBreakMode = .byWordWrapping
        labelSubtext.numberOfLines = 0
        
        switch alignment as String {
        case "left":
            labelSubtext.textAlignment = .left
        case "right":
            labelSubtext.textAlignment = .right
        case "center":
            labelSubtext.textAlignment = .center
        default:
            break
        }
        
        sizeLabelSubtext = labelSubtext.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 48, height: CGFloat.greatestFiniteMagnitude))
        
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - 48 - sizeLabelSubtext.height - sizeButton.height)
        
        labelSubtext.frame = CGRect(origin: point, size: sizeLabelSubtext)
        
        view.addSubview(labelSubtext)
    }
    
    func createButton(type: UIButtonType,
                      text: NSString,
                      sizeText: NSInteger,
                      alignment: NSString,
                      background: UIColor,
                      color: UIColor) {
        let newButton = UIButton(type: type)
        newButton.backgroundColor = background
        newButton.setTitle(text as String?, for: .normal)
        newButton.setTitleColor(color, for: .normal)
        newButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeText))!
        newButton.titleLabel?.textAlignment = .center
        
        sizeButton = newButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        var point = CGPoint()
        
        switch alignment as String {
        case "left":
            point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (24 + sizeButton.height))
        case "right":
            point = CGPoint(x: UIScreen.main.bounds.width - (24 + sizeButton.width), y: UIScreen.main.bounds.height - (24 + sizeButton.height))
        case "center":
            point = CGPoint(x: (UIScreen.main.bounds.width - sizeButton.width) / 2, y: UIScreen.main.bounds.height - (24 + sizeButton.height))
        default:
            break
        }
        
        newButton.frame = CGRect(origin: point, size: sizeButton)
        
        view.addSubview(newButton)
    }
    
    func deleteAllSubviews() {
        view.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func builder(snap: SnapModel, button: ButtonModel) {
        if let image = snap.image {
            imageView.image = UIImage(named: image as String)
        }
        
        if let text = button.text {
            createButton(type: .custom, text: text, sizeText: button.sizeText, alignment: button.alignment, background: UIColor.red, color: UIColor.black)
        }
        
        if let subtext = snap.subtext {
            createLabelSubtext(subtext: subtext, sizeSubtext: snap.sizeSubtext, alignment: snap.alignment, color: UIColor.white)
        }
        
        if let text = snap.text {
            createLabelText(text: text, sizeText: snap.sizeText, alignment: snap.alignment, color: UIColor.white)
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

