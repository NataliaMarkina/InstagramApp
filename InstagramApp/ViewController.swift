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
        currentIndex = index
        showSnap(index: currentIndex)
    }
    
    var imageView: UIImageView!
    var contextView: UIView!
    var tableView: UITableView!
    //var bottomPanel: UIView!
    //var buttonLike: UIButton!
    //var buttonDislike: UIButton!
    //var buttonMarks: UIButton!
    private var progressBar: ProgressBar!
    var voting: VotingModel!
    var buttonArray = [ButtonModel]()
    var bottomPanelArray = [BottomPanelModel]()
    var votingArray = [VotingModel]()
    var snapArray = [SnapModel]()
    var durationArray = [TimeInterval]()
    var answerOptions = [String]()
    var currentHeight: CGFloat = 101
    var bottomPanelHeight: CGFloat = 50
    var currentTheme: String!
    let idCell = "answerCell"
    var currentIndex: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        //voting = VotingModel(title: "Вопрос в опросе", voted: nil, options: [(title: "Вариант 1", count: 5), (title: "Вариант 2", count: 10), (title: "Вариант 3", count: 3), (title: "Вариант 4", count: 7)])
        
        //tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
        //tableView.backgroundColor = #colorLiteral(red: 0.7723932573, green: 0.4718477153, blue: 1, alpha: 1)
        //tableView.setContentOffset(CGPoint(x: 24, y: 24), animated: false)
        //tableView.dataSource = self
        //tableView.delegate = self
        //tableView.register(PollTableViewCell.self, forCellReuseIdentifier: idCell)
        //view.addSubview(tableView)

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
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "center", image: "img2", theme: "light", duration: 5.0, alignmentButton: "center", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: nil, voted: nil, options: [])
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "left", image: "img6", theme: "dark", duration: 10.0, alignmentButton: "left", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: nil, voted: nil, options: [])
        
        createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "right", image: "img5", theme: "light", duration: 1.0, alignmentButton: "right", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: nil, voted: nil, options: [])
        
        //createSnap(textSnap: "Заголовок в две строки", subtextSnap: "Расположение эпизодов неумеренно индуцирует культурный дактиль. Целевой трафик, следовательно, обуславливает дактиль.", sizeTextSnap: 50, sizeSubtextSnap: 30, alignmentSnap: "right", image: "img5", theme: "light", duration: 1.0, alignmentButton: "right", textButton: "Большая кнопка", action: "", sizeTextButton: 20, titleVoting: "Вопрос в опросе", voted: nil, options: [(title: "Вариант 1", count: 0), (title: "Вариант 2", count: 0), (title: "Вариант 3", count: 0), (title: "Вариант 4", count: 0)])
        
        showSnap(index: 0)
    
        progressBar = ProgressBar(countSegments: snapArray.count, duration: durationArray, color: UIColor.white)
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
                    alignmentButton: String,
                    textButton: String?,
                    action: String,
                    sizeTextButton: Int,
                    titleVoting: String?,
                    voted: Int?,
                    options: [(title: String, count: Int)]) {
        let button = ButtonModel(alignment: alignmentButton, text: textButton, action: action, sizeText: sizeTextButton)
        let voting = VotingModel(title: titleVoting, voted: voted, options: options)
        let bottomPanel = BottomPanelModel(likeIcon: "like_icon", dislikeIcon: "dislike_icon", marksIcon: "marks_icon", selectedLikeIcon: false, selectedDislikeIcon: false, selectedMarksIcon: false)
        let snap = SnapModel(text: textSnap, subtext: subtextSnap, sizeText: sizeTextSnap, sizeSubtext: sizeSubtextSnap, alignment: alignmentSnap, image: image, theme: theme, duration: duration, button: button, voting: voting, bottomPanel: bottomPanel)
        
        buttonArray.append(button)
        bottomPanelArray.append(bottomPanel)
        snapArray.append(snap)
        durationArray.append(duration)
    }
    
    func showSnap(index: Int) {
        deleteAllSubviews()
        builder(snap: snapArray[index], button: buttonArray[index], bottomPanel: bottomPanelArray[index])
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
        
        currentHeight += sizeLabelSubtext.height + 16
        
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
    
    func createBottomPanel(bottomPanel: BottomPanelModel) {
        let newBottomPanel = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - bottomPanelHeight, width: UIScreen.main.bounds.width, height: bottomPanelHeight))
        contextView.addSubview(newBottomPanel)
        
        let likeIcon = UIImage(named: bottomPanel.likeIcon)
        let buttonLike = UIButton()
        if (snapArray[currentIndex].bottomPanel.selectedLikeIcon) {
            let newImage: UIImage!
            
            if currentTheme == "light" {
                newImage = likeIcon?.maskWithColor(color: UIColor.white)
            } else {
                newImage = likeIcon?.maskWithColor(color: UIColor.black)
            }
            
            buttonLike.setImage(newImage, for: .selected)
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
        if (snapArray[currentIndex].bottomPanel.selectedDislikeIcon) {
            let newImage: UIImage!
            
            if currentTheme == "light" {
                newImage = dislikeIcon?.maskWithColor(color: UIColor.white)
            } else {
                newImage = dislikeIcon?.maskWithColor(color: UIColor.black)
            }
            
            buttonDislike.setImage(newImage, for: .selected)
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
        if (snapArray[currentIndex].bottomPanel.selectedMarksIcon) {
            let newImage = UIImage(named: "marks_icon_selected")
            
            if currentTheme == "light" {
                buttonMarks.setImage(newImage, for: .selected)
            } else {
                buttonMarks.setImage(newImage?.maskWithColor(color: UIColor.black), for: .selected)
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
        snapArray[currentIndex].bottomPanel.selectedLikeIcon = !snapArray[currentIndex].bottomPanel.selectedLikeIcon
        
        if sender.isSelected {
            let newImage: UIImage!
            
            if currentTheme == "light" {
                newImage = sender.image(for: .normal)?.maskWithColor(color: UIColor.white)
            } else {
                newImage = sender.image(for: .normal)?.maskWithColor(color: UIColor.black)
            }
            
            sender.setImage(newImage, for: .selected)
            
            sender.alpha = 1
        } else {
            sender.setImage(sender.image(for: .selected)?.maskWithColor(color: UIColor.white), for: .normal)
            sender.alpha = 0.5
        }
    }
    
    @objc func clickDislikeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        snapArray[currentIndex].bottomPanel.selectedDislikeIcon = !snapArray[currentIndex].bottomPanel.selectedDislikeIcon
        
        if sender.isSelected {
            let newImage: UIImage!
            
            if currentTheme == "light" {
                newImage = sender.image(for: .normal)?.maskWithColor(color: UIColor.white)
            } else {
                newImage = sender.image(for: .normal)?.maskWithColor(color: UIColor.black)
            }
            
            sender.setImage(newImage, for: .selected)
            
            sender.alpha = 1
        } else {
            sender.setImage(sender.image(for: .selected)?.maskWithColor(color: UIColor.white), for: .normal)
            sender.alpha = 0.5
        }
    }
    
    @objc func clickMarksButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        snapArray[currentIndex].bottomPanel.selectedMarksIcon = !snapArray[currentIndex].bottomPanel.selectedMarksIcon
        
        let newImage = UIImage(named: "marks_icon_selected")
        
        if sender.isSelected && currentTheme == "light" {
            sender.setImage(newImage, for: .selected)
        } else if sender.isSelected && currentTheme == "dark" {
            sender.setImage(newImage?.maskWithColor(color: UIColor.black), for: .selected)
        } else {
            sender.setImage(UIImage(named: "marks_icon"), for: .normal)
        }
    }
    
    func deleteAllSubviews() {
        contextView.subviews.forEach({ $0.removeFromSuperview() })
        contextView.addSubview(imageView)
        currentHeight = bottomPanelHeight + 24
    }
    
    func builder(snap: SnapModel, button: ButtonModel, bottomPanel: BottomPanelModel) {
        var buttonBackground: UIColor!
        var buttonTextColor: UIColor!
        var textColor: UIColor!
        
        currentTheme = snap.theme
        
        if currentTheme == "light" {
            buttonBackground = UIColor.white
            buttonTextColor = UIColor.black
            textColor = UIColor.white
        } else {
            buttonBackground = UIColor.black
            buttonTextColor = UIColor.white
            textColor = UIColor.black
        }
        
        if let image = snap.image {
            imageView.image = UIImage(named: image)
        }
        
        createBottomPanel(bottomPanel: bottomPanel)
        
        if let text = button.text {
            createButton(type: .custom, text: text, sizeText: button.sizeText, alignment: button.alignment, background: buttonBackground, color: buttonTextColor)
        }
        
        if let subtext = snap.subtext {
            createLabelSubtext(subtext: subtext, sizeSubtext: snap.sizeSubtext!, alignment: snap.alignment, color: textColor)
        }
        
        if let text = snap.text {
            createLabelText(text: text, sizeText: snap.sizeText!, alignment: snap.alignment, color: textColor)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        //let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! PollTableViewCell
        //cell.textLabel?.text = voting.options[indexPath.section].title
        cell.backgroundColor = UIColor.clear
        
        let bottomViewCell = UIView(frame: CGRect(x: 24, y: 0, width: UIScreen.main.bounds.width - 48, height: 54))
        bottomViewCell.backgroundColor = #colorLiteral(red: 0.8842288507, green: 0.8352838254, blue: 1, alpha: 0.3311234595)
        bottomViewCell.layer.cornerRadius = 12
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: bottomViewCell.frame.width, height: bottomViewCell.frame.height))
        label.text = voting.options[indexPath.section].title
        label.textColor = UIColor.white
        bottomViewCell.addSubview(label)
        cell.addSubview(bottomViewCell)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return voting.options.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var allCount = 0
        for index in 0..<voting.options.count {
            allCount += voting.options[index].count
        }
        
        for index in 0..<voting.options.count {
            let topViewCell = UIView(frame: CGRect(x: 24, y: 0, width: CGFloat(voting.options[index].count) / CGFloat(allCount) * (UIScreen.main.bounds.width - 48), height: 54))
            topViewCell.backgroundColor = #colorLiteral(red: 0.8842288507, green: 0.8352838254, blue: 1, alpha: 0.5)
            topViewCell.layer.cornerRadius = 12
            tableView.cellForRow(at: IndexPath(row: 0, section: index))?.addSubview(topViewCell)
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
