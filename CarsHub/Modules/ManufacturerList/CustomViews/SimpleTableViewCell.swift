//
//  SimpleTableViewCell.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textColor = UIColor(named: "tableCellTitleColor")
    }
    
    func fillCell(cellViewModel: SimpleTableViewCellViewModel) {
        
        let oddBg = UIColor(named: "tableCellOddRowBackground")
        let evenBg = UIColor(named: "tableCellEvenRowBackground")
        contentView.backgroundColor = cellViewModel.isEven ? evenBg : oddBg
        
        textLabel?.text = cellViewModel.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
