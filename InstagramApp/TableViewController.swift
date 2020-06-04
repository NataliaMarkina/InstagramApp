//
//  TableViewController.swift
//  InstagramApp
//
//  Created by Natalia on 02.06.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var votingArray: [VotingModel]!
    var currentIndex: Int!
    
    enum Const {
        static var currentHeight: CGFloat = 101
        static let idCell = "answerCell"
    }
    
    init(style: UITableViewStyle, votingArray: [VotingModel], currentIndex: Int) {
        super.init(style: style)
        
        self.votingArray = votingArray
        self.currentIndex = currentIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Const.idCell)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.idCell) as! TableViewCell
        cell.label.text = votingArray[currentIndex].options[indexPath.section].title
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return votingArray[currentIndex].options.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    /*override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width - 48, height: tableView.contentSize.height)
    }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if votingArray[currentIndex].voted == nil {
            votingArray[currentIndex].voted = indexPath.section + 1
            votingArray[currentIndex].options[indexPath.section].count += 1
            
            var allCount = 0
            for index in 0..<votingArray[currentIndex].options.count {
                allCount += votingArray[currentIndex].options[index].count
            }
            
            for index in 0..<votingArray[currentIndex].options.count {
                let topViewCell = UIView(frame: CGRect(x: 24, y: 0, width: CGFloat(votingArray[currentIndex].options[index].count) / CGFloat(allCount) * (UIScreen.main.bounds.width - 48), height: 54))
                topViewCell.backgroundColor = #colorLiteral(red: 0.8842288507, green: 0.8352838254, blue: 1, alpha: 0.5)
                topViewCell.layer.cornerRadius = 12
                tableView.cellForRow(at: IndexPath(row: 0, section: index))?.addSubview(topViewCell)
                
                let label = UILabel()
                if indexPath.section == index {
                    label.text = "✓ \(Int(CGFloat(votingArray[currentIndex].options[index].count) / CGFloat(allCount) * 100))%"
                } else {
                    label.text = "\(Int(CGFloat(votingArray[currentIndex].options[index].count) / CGFloat(allCount) * 100))%"
                }
                label.textColor = UIColor.white
                let sizeLabel = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
                label.frame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.width - 48 - sizeLabel.width, y: (54 - sizeLabel.height) / 2), size: sizeLabel)
                tableView.cellForRow(at: IndexPath(row: 0, section: index))?.addSubview(label)
            }
        }
    }
}
