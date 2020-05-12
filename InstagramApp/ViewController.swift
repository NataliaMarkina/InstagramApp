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
    var pickerController: UIImagePickerController!
    var imageArr = [UIImage]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        imageView.contentMode = .scaleAspectFit
        
        imageArr.append(#imageLiteral(resourceName: "img1"))
        imageArr.append(#imageLiteral(resourceName: "img2"))
        imageArr.append(#imageLiteral(resourceName: "img3"))
        imageArr.append(#imageLiteral(resourceName: "img4"))
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageArr.append(chosenImage)
        progressBar.addNewImage()
        progressBar.animation()
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

