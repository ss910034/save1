//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class CCCell3TableViewCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textView.text = "輸入內容"
        textView.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
