//
//  TableViewCell.swift
//  InstagramApp
//
//  Created by Natalia on 01.06.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var label: UILabel!
    var bottomViewCell: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        bottomViewCell = UIView(frame: CGRect(x: 24, y: 0, width: UIScreen.main.bounds.width - 48, height: 54))
        bottomViewCell.backgroundColor = #colorLiteral(red: 0.8842288507, green: 0.8352838254, blue: 1, alpha: 0.3311234595)
        bottomViewCell.layer.cornerRadius = 12
        label = UILabel(frame: CGRect(x: 10, y: 0, width: bottomViewCell.frame.width, height: bottomViewCell.frame.height))
        label.textColor = UIColor.white
        bottomViewCell.addSubview(label)
        self.addSubview(bottomViewCell)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
