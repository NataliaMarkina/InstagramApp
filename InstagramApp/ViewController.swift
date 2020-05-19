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
        //showImage(index: index)
    }
    

    @IBOutlet weak var imageView: UIImageView!
    //var imageView: UIImageView!
    private var progressBar: ProgressBar!
    var pickerController = UIImagePickerController()
    //var imageArr = [UIImage]()
    var button: ButtonModel!
    var snap: SnapModel!
    var sizeButton: CGSize!
    var sizeLabel: CGSize!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imageView.backgroundColor = UIColor.white
        view.addSubview(imageView)
        
        let viewTapSkip = UIView(frame: CGRect(x: 125, y: 0, width: UIScreen.main.bounds.width - 125, height: UIScreen.main.bounds.height))
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(skip(_:)))
        view.addGestureRecognizer(recognizer)*/
        
        pickerController.delegate = self
        
        imageView.contentMode = .scaleAspectFill
        
        button = ButtonModel(alignment: "left", color: "black", background: "red", text: "Button", action: "", sizeText: 40)
        snap = SnapModel(text: "Hello", subtext: "Hello", sizeText: 50, alignment: "center", image: "img1", theme: "", duration: 5, button: button)
        
        builder()
        
        /*imageArr.append(#imageLiteral(resourceName: "img1"))
        imageArr.append(#imageLiteral(resourceName: "img2"))
        imageArr.append(#imageLiteral(resourceName: "img3"))
        imageArr.append(#imageLiteral(resourceName: "img4"))
        
        let img = textToImage(text: "Hello World!", image: UIImage(named:"img4.jpg")!, point: CGPoint(x: 0, y: 0))
        
        imageArr.append(img)
        
        let img1 = createButton(type: .custom, image: UIImage(named:"img4.jpg")!, point: CGPoint(x: 500, y: 600), text: "Button")
        
        imageArr.append(img1)
        
        showImage(index: 0)*/
    
        progressBar = ProgressBar(countSegments: 3, duration: 5.0)
        progressBar.deligate = self
        progressBar.frame = CGRect(x: 15, y: 50, width: view.frame.width - 30, height: 6)
        
        view.addSubview(progressBar)
        
        progressBar.animation()
    }
    
    /*func showImage(index: Int) {
        imageView.image = imageArr[index]
    }*/

    @objc func skip(_ sender: UITapGestureRecognizer) {
        progressBar.skip()
    }
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        progressBar.back()
    }
    
    @IBAction func paused(_ sender: UILongPressGestureRecognizer) {
        progressBar.isPaused = !progressBar.isPaused
    }
    
    func textToImage(text: NSString, image: UIImage, point: CGPoint) {
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
    }
    
    func createLabel(text: NSString,
                     sizeText: NSInteger,
                     alignment: NSString,
                     color: UIColor) {
        let label = UILabel()
        label.text = text as String
        label.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeText))!
        label.textColor = color
        
        switch alignment as String {
        case "left":
            label.textAlignment = .left
        case "right":
            label.textAlignment = .right
        case "center":
            label.textAlignment = .center
        default:
            break
        }
        
        sizeLabel = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - 48 - sizeLabel.height - sizeButton.height)
        
        label.frame = CGRect(origin: point, size: sizeLabel)
        
        view.addSubview(label)
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
    
    func builder() {
        imageView.image = UIImage(named: snap.image as String)!
        
        /*let labelText = UILabel()
        labelText.text = snap.text as String
        let sizeText = labelText.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        let recText = CGRect(origin: CGPoint(x: 0, y: 0), size: sizeText)
        let resultLabelText = UILabel(frame: recText)
        resultLabelText.text = snap.text as String
        resultLabelText.backgroundColor = UIColor.brown*/
        
        //textToImage(text: snap.text, image: UIImage(named:"img4.jpg")!, point: CGPoint(x: 0, y: 0))
        
        //view.addSubview(resultLabelText)
        
        createLabel(text: snap.text, sizeText: snap.sizeText, alignment: snap.alignment, color: UIColor.white)
        createButton(type: .custom, text: button.text, sizeText: button.sizeText, alignment: button.alignment, background: UIColor.red, color: UIColor.black)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageArr.append(chosenImage)
            progressBar.addNewImage()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIButton) {
        pickerController.allowsEditing = false
        pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }*/
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

