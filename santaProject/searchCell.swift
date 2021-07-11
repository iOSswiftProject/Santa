//
//  searchCell.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/26.
//

import UIKit

class searchCell: UITableViewCell {
    var mountainLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mountainLabel.text = ""
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeMountainLabel() {
        mountainLabel = UILabel()
        
    }
}
