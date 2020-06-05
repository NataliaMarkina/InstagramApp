//
//  ViewController.swift
//  InstagramApp
//
//  Created by Natalia on 08.05.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProgressBarDelegate {
    
    var imageView: UIImageView!
    var contextView: UIView!
    var closeButton: UIButton!
    var tableViewController: TableViewController!
    private var progressBar: ProgressBar!
    var buttonArray = [ButtonModel]()
    var bottomPanelArray = [BottomPanelModel]()
    var votingArray = [VotingModel]()
    var snapArray = [SnapModel]()
    var durationArray = [TimeInterval]()
    var answerOptions = [String]()
    var currentTheme: String!
    
    enum Const {
        static var currentHeight: CGFloat = 101
        static let bottomPanelHeight: CGFloat = 50
        static var currentIndex: Int = 0
        static let idCell = "answerCell"
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib

        contextView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.addSubview(contextView)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        contextView.addSubview(imageView)
        
        closeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 36, y: 36, width: 16, height: 16))
        closeButton.setImage(UIImage(named: "close_icon"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonClick(_:)), for: .touchUpInside)
        view.addSubview(closeButton)
        
        let recognizerLongPress = UILongPressGestureRecognizer(target: self, action: #selector(paused(_:)))
        view.addGestureRecognizer(recognizerLongPress)
        
        let recognizerTap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        view.addGestureRecognizer(recognizerTap)
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentTextSnap: "center", image: "img2", theme: "light", duration: 5.0, alignmentButton: "center", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: nil, voted: nil, options: [])
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentTextSnap: "left", image: "img6", theme: "dark", duration: 3.0, alignmentButton: "left", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: nil, voted: nil, options: [])
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentTextSnap: "right", image: "img5", theme: "light", duration: 1.0, alignmentButton: "right", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: nil, voted: nil, options: [])
        
        createSnap(textSnap: nil, subtextSnap: nil, sizeTextSnap: 50, sizeSubtextSnap: nil, alignmentTextSnap: "left", image: nil, theme: "light", duration: 5.0, alignmentButton: nil, textButton: nil, action: "", sizeTextButton: nil, titleVoting: "Вопрос в опросе", voted: nil, options: [(title: "Вариант 1", count: 0), (title: "Вариант 2", count: 0), (title: "Вариант 3", count: 0), (title: "Вариант 4", count: 0)])
        
        showSnap(index: 0)
    
        progressBar = ProgressBar(countSegments: snapArray.count, duration: durationArray, color: UIColor.white)
        progressBar.delegate = self
        progressBar.frame = CGRect(x: 12, y: 12, width: view.frame.width - 24, height: 3)
        
        view.addSubview(progressBar)
        
        progressBar.animation()
    }
    
    func changedIndex(index: Int) {
        Const.currentIndex = index
        showSnap(index: Const.currentIndex)
    }
    
    func createSnap(textSnap: String?,
                    subtextSnap: String?,
                    sizeTextSnap: Int?,
                    sizeSubtextSnap: Int?,
                    alignmentTextSnap: String?,
                    image: String?,
                    theme: String,
                    duration: TimeInterval,
                    alignmentButton: String?,
                    textButton: String?,
                    action: String,
                    sizeTextButton: Int?,
                    titleVoting: String?,
                    voted: Int?,
                    options: [(title: String, count: Int)]) {
        let button = ButtonModel(alignment: alignmentButton, text: textButton, action: action, sizeText: sizeTextButton)
        let voting = VotingModel(title: titleVoting, voted: voted, options: options)
        let bottomPanel = BottomPanelModel(likeIcon: "like_icon", dislikeIcon: "dislike_icon", marksIcon: "marks_icon", selectedLikeIcon: false, selectedDislikeIcon: false, selectedMarksIcon: false)
        let snap = SnapModel(text: textSnap, subtext: subtextSnap, sizeText: sizeTextSnap, sizeSubtext: sizeSubtextSnap, alignment: alignmentTextSnap, image: image, theme: theme, duration: duration, button: button, voting: voting, bottomPanel: bottomPanel)
        
        buttonArray.append(button)
        bottomPanelArray.append(bottomPanel)
        votingArray.append(voting)
        snapArray.append(snap)
        durationArray.append(duration)
    }
    
    func showSnap(index: Int) {
        deleteAllSubviews()
        builder(snap: snapArray[index], button: buttonArray[index], bottomPanel: bottomPanelArray[index], voting: votingArray[index])
    }
    
    @objc func closeButtonClick(_ sender: UIButton) {
        print("Close button clicked")
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        if sender.location(in: view).x < UIScreen.main.bounds.width / 3 {
            progressBar.back()
        } else {
            progressBar.skip()
        }
        /*if let x = sender.location(in: tableViewController.tableView) {
            print(sender.location(in: tableViewController.tableView))
        }*/
        
    }
    
    @objc func paused(_ sender: UILongPressGestureRecognizer) {
        progressBar.isPaused = !progressBar.isPaused
    }
    
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
     
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (Const.currentHeight + sizeLabelText.height))
        
        Const.currentHeight += sizeLabelText.height
     
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
        
        let point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (Const.currentHeight + sizeLabelSubtext.height))
        
        Const.currentHeight += sizeLabelSubtext.height + 16
        
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
        newButton.layer.cornerRadius = 6
        newButton.setTitle(text, for: .normal)
        newButton.setTitleColor(color, for: .normal)
        newButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: CGFloat(sizeText))!
        newButton.titleLabel?.textAlignment = .center
        newButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
        /*let sizeButton = newButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        var point = CGPoint()
        
        switch alignment {
        case "left":
            point = CGPoint(x: 24, y: UIScreen.main.bounds.height - (Const.currentHeight + sizeButton.height))
        case "right":
            point = CGPoint(x: UIScreen.main.bounds.width - (24 + sizeButton.width), y: UIScreen.main.bounds.height - (Const.currentHeight + sizeButton.height))
        case "center":
            point = CGPoint(x: (UIScreen.main.bounds.width - sizeButton.width) / 2, y: UIScreen.main.bounds.height - (Const.currentHeight + sizeButton.height))
        default:
            break
        }
        
        Const.currentHeight += sizeButton.height + 24
        
        newButton.frame = CGRect(origin: point, size: sizeButton)*/
        
        newButton.frame = CGRect(x: 24, y: UIScreen.main.bounds.height - (Const.currentHeight + 64), width: UIScreen.main.bounds.width - 48, height: 64)
        
        Const.currentHeight += newButton.frame.height + 24
        
        contextView.addSubview(newButton)
    }
    
    func createTitleVoting(text: String,
                           sizeText: Int,
                           alignment: String,
                           color: UIColor,
                           heightTable: CGFloat) {
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
        
        labelText.frame = CGRect(x: 24, y: (UIScreen.main.bounds.height - sizeLabelText.height - heightTable) / 2, width: UIScreen.main.bounds.width - 48, height: sizeLabelText.height)
        
        Const.currentHeight = (UIScreen.main.bounds.height - sizeLabelText.height - heightTable) / 2 + sizeLabelText.height
        
        contextView.addSubview(labelText)
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        print("Button clicked")
    }
    
    func createVoting(title: String) {
        imageView.backgroundColor = #colorLiteral(red: 0.7723932573, green: 0.4718477153, blue: 1, alpha: 1)
        
        tableViewController = TableViewController(style: .grouped, votingArray: votingArray, currentIndex: Const.currentIndex)
        let heightTable = CGFloat(tableViewController.tableView.numberOfSections) * 66.0
        
        createTitleVoting(text: title, sizeText: 40, alignment: "left", color: UIColor(named: "White")!, heightTable: heightTable)
        
        tableViewController.tableView.frame = CGRect(x: 0, y: Const.currentHeight, width: UIScreen.main.bounds.width, height: heightTable)
        
        contextView.addSubview(tableViewController.tableView)
    }
    
    func getNewImage(image: UIImage) -> UIImage {
        let newImage: UIImage!
        
        if currentTheme == "light" {
            newImage = image.maskWithColor(color: UIColor(named: "White")!)
        } else {
            newImage = image.maskWithColor(color: UIColor(named: "Black")!)
        }
        
        return newImage
    }
    
    func createBottomPanel(bottomPanel: BottomPanelModel) {
        let newBottomPanel = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - Const.bottomPanelHeight, width: UIScreen.main.bounds.width, height: Const.bottomPanelHeight))
        contextView.addSubview(newBottomPanel)
        
        let likeIcon = UIImage(named: bottomPanel.likeIcon)
        let buttonLike = UIButton()
        if (snapArray[Const.currentIndex].bottomPanel.selectedLikeIcon) {
            buttonLike.setImage(getNewImage(image: likeIcon!), for: .selected)
            buttonLike.isSelected = true
            buttonLike.alpha = 1
        } else {
            buttonLike.setImage(likeIcon, for: .normal)
            buttonLike.isSelected = false
            buttonLike.alpha = 0.5
        }
        let sizeButtomLike = buttonLike.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        buttonLike.frame = CGRect(origin: CGPoint(x: 24, y: 0), size: sizeButtomLike)
        buttonLike.addTarget(self, action: #selector(clickLikeButton(_:)), for: .touchUpInside)
        newBottomPanel.addSubview(buttonLike)
        
        let dislikeIcon = UIImage(named: bottomPanel.dislikeIcon)
        let buttonDislike = UIButton()
        if (snapArray[Const.currentIndex].bottomPanel.selectedDislikeIcon) {
            buttonDislike.setImage(getNewImage(image: dislikeIcon!), for: .selected)
            buttonDislike.isSelected = true
            buttonDislike.alpha = 1
        } else {
            buttonDislike.setImage(dislikeIcon, for: .normal)
            buttonDislike.isSelected = false
            buttonDislike.alpha = 0.5
        }
        let sizeButtomDislike = buttonDislike.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        buttonDislike.frame = CGRect(origin: CGPoint(x: 48 + sizeButtomLike.width, y: 0), size: sizeButtomDislike)
        buttonDislike.addTarget(self, action: #selector(clickDislikeButton(_:)), for: .touchUpInside)
        newBottomPanel.addSubview(buttonDislike)
        
        let marksIcon = UIImage(named: bottomPanel.marksIcon)
        let buttonMarks = UIButton()
        if (snapArray[Const.currentIndex].bottomPanel.selectedMarksIcon) {
            let newImage = UIImage(named: "marks_icon_selected")
            
            if currentTheme == "light" {
                buttonMarks.setImage(newImage, for: .selected)
            } else {
                buttonMarks.setImage(newImage?.maskWithColor(color: UIColor(named: "Black")!), for: .selected)
            }
            
            buttonMarks.isSelected = true
        } else {
            buttonMarks.setImage(marksIcon, for: .normal)
            buttonMarks.isSelected = false
        }
        let sizeButtomMarks = buttonMarks.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        buttonMarks.frame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.width - 24 - sizeButtomMarks.width, y: 0), size: sizeButtomMarks)
        buttonMarks.addTarget(self, action: #selector(clickMarksButton(_:)), for: .touchUpInside)
        newBottomPanel.addSubview(buttonMarks)
    }
    
    @objc func clickLikeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        snapArray[Const.currentIndex].bottomPanel.selectedLikeIcon = !snapArray[Const.currentIndex].bottomPanel.selectedLikeIcon
        
        if sender.isSelected {
            sender.setImage(getNewImage(image: sender.image(for: .normal)!), for: .selected)
            sender.alpha = 1
        } else {
            sender.setImage(sender.image(for: .selected)?.maskWithColor(color: UIColor(named: "Black")!), for: .normal)
            sender.alpha = 0.5
        }
    }
    
    @objc func clickDislikeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        snapArray[Const.currentIndex].bottomPanel.selectedDislikeIcon = !snapArray[Const.currentIndex].bottomPanel.selectedDislikeIcon
        
        if sender.isSelected {
            sender.setImage(getNewImage(image: sender.image(for: .normal)!), for: .selected)
            sender.alpha = 1
        } else {
            sender.setImage(sender.image(for: .selected)?.maskWithColor(color: UIColor(named: "White")!), for: .normal)
            sender.alpha = 0.5
        }
    }
    
    @objc func clickMarksButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        snapArray[Const.currentIndex].bottomPanel.selectedMarksIcon = !snapArray[Const.currentIndex].bottomPanel.selectedMarksIcon
        
        let newImage = UIImage(named: "marks_icon_selected")
        
        if sender.isSelected && currentTheme == "light" {
            sender.setImage(newImage, for: .selected)
        } else if sender.isSelected && currentTheme == "dark" {
            sender.setImage(newImage?.maskWithColor(color: UIColor(named: "Black")!), for: .selected)
        } else {
            sender.setImage(UIImage(named: "marks_icon"), for: .normal)
        }
    }
    
    func deleteAllSubviews() {
        contextView.subviews.forEach({ $0.removeFromSuperview() })
        imageView.image = nil
        contextView.addSubview(imageView)
        Const.currentHeight = Const.bottomPanelHeight + 24
    }
    
    func builder(snap: SnapModel, button: ButtonModel, bottomPanel: BottomPanelModel, voting: VotingModel) {
        var buttonBackground: UIColor!
        var buttonTextColor: UIColor!
        var textColor: UIColor!
        
        currentTheme = snap.theme
        
        if currentTheme == "light" {
            buttonBackground = UIColor(named: "White")!
            buttonTextColor = UIColor(named: "Black")!
            textColor = UIColor(named: "White")!
        } else {
            buttonBackground = UIColor(named: "Black")!
            buttonTextColor = UIColor(named: "White")!
            textColor = UIColor(named: "Black")!
        }
        
        if let image = snap.image {
            imageView.image = UIImage(named: image)
        }
        
        createBottomPanel(bottomPanel: bottomPanel)
        
        if let text = button.text {
            createButton(type: .custom, text: text, sizeText: button.sizeText!, alignment: button.alignment!, background: buttonBackground, color: buttonTextColor)
        }
        
        if let subtext = snap.subtext {
            createLabelSubtext(subtext: subtext, sizeSubtext: snap.sizeSubtext!, alignment: snap.alignment!, color: textColor)
        }
        
        if let text = snap.text {
            createLabelText(text: text, sizeText: snap.sizeText!, alignment: snap.alignment!, color: textColor)
        }
        
        if let title = voting.title {
            createVoting(title: title)
        }
    }
}

extension UIImage {
    public func maskWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        color.setFill()
        self.draw(in: rect)
        
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
}
