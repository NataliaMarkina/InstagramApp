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
        showImage(index: index)
    }
    

    @IBOutlet weak var imageView: UIImageView!
    private var progressBar: ProgressBar!
    var pickerController = UIImagePickerController()
    var imageArr = [UIImage]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerController.delegate = self
        
        imageView.contentMode = .scaleAspectFit
        
        imageArr.append(#imageLiteral(resourceName: "img1"))
        imageArr.append(#imageLiteral(resourceName: "img2"))
        imageArr.append(#imageLiteral(resourceName: "img3"))
        imageArr.append(#imageLiteral(resourceName: "img4"))
        
        let img = textToImage(text: "Hello World!", image: UIImage(named:"img4.jpg")!, point: CGPoint(x: 0, y: 0))
        
        imageArr.append(img)
        
        let img1 = createButton(type: .custom, image: UIImage(named:"img4.jpg")!, point: CGPoint(x: 500, y: 600), text: "Button")
        
        imageArr.append(img1)
        
        showImage(index: 0)
    
        progressBar = ProgressBar(countSegments: imageArr.count)
        progressBar.deligate = self
        progressBar.frame = CGRect(x: 15, y: 50, width: view.frame.width - 30, height: 6)
        
        view.addSubview(progressBar)
        
        progressBar.animation()
    }
    
    func showImage(index: Int) {
        imageView.image = imageArr[index]
    }

    @IBAction func skip(_ sender: UITapGestureRecognizer) {
        progressBar.skip()
    }
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        progressBar.back()
    }
    
    @IBAction func paused(_ sender: UILongPressGestureRecognizer) {
        progressBar.isPaused = !progressBar.isPaused
    }
    
    func textToImage(text: NSString, image: UIImage, point: CGPoint) -> UIImage{
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
        
        return newImage!
    }
    
    func createButton(type: UIButtonType, image: UIImage, point: CGPoint, text: String? = nil, sizeText: CGFloat = 50, width: CGFloat = 300, height: CGFloat = 100, radius: CGFloat = 6, background: UIColor = UIColor.white, color: UIColor = UIColor.black) -> UIImage {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let newImageView = UIImageView(image: image)
        
        newView.addSubview(newImageView)
        
        let button = UIButton(type: type)
        button.frame = CGRect(x: point.x, y: point.y, width: width, height: height)
        button.backgroundColor = background
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Bold", size: sizeText)!
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = radius
        
        newView.addSubview(button)
        
        return newView.asImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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

