//
//  BaseTableViewCell.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var label: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = ""
        return lbl
    }()
    private lazy var descLabel: UILabel = {
        let lbl = BaseLabel()
        lbl.text = ""
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearData()
    }
    
    func configure(with viewModel: BaseCellViewModel?) {
        
        if let textWithStyle = viewModel?.title?.text {
            label.text = textWithStyle.text
            label.font = textWithStyle.font ?? UIFont.systemFont(ofSize: 18)
            label.textColor = textWithStyle.color ?? .black
            label.textAlignment = textWithStyle.alignment ?? .left
        }
        
        if let attributedText = viewModel?.title?.attributedText {
            label.attributedText = attributedText
        }
        
        if let textWithStyle = viewModel?.description?.text {
            descLabel.text = textWithStyle.text
            descLabel.font = textWithStyle.font ?? UIFont.systemFont(ofSize: 18)
            descLabel.textColor = textWithStyle.color ?? .black
            descLabel.textAlignment = textWithStyle.alignment ?? .left
        }
        
        if let attributedText = viewModel?.description?.attributedText {
            descLabel.attributedText = attributedText
        }
        
        self.imgView.loadImage(from: viewModel?.imageUrl, withPlaceholder: nil)
    }
    
}

//MARK:- Initial setup
extension BaseTableViewCell {
    func initialSetup() {
        
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        setImgView()
        setLabel()
        setDescription()
    }
    
    func setImgView() {
        self.addSubview(imgView)
        addConstrainsToImage()
    }
    
    func setLabel() {
        self.label = BaseLabel()
        self.addSubview(label)
        
        addConstrainsToLabel()
    }
    
    func setDescription() {
        self.descLabel = BaseLabel()
        self.addSubview(descLabel)
        
        addConstrainsToDescLabel()
    }
    
    func clearData() {
        label.text = ""
        descLabel.text = ""
        imgView.image = UIImage.init(named: "placeholder")
    }
}

//MARK: - Constraints related methods
extension BaseTableViewCell {
    func addConstrainsToLabel() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let leading =  self.label.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 10)
        let top =  self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        let trailing =  self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        
        self.addConstraints([leading, top, trailing])
    }
    
    func addConstrainsToDescLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leading =  self.descLabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 10)
        let top =  self.descLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 5)
        let trailing =  self.descLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        
        let bottom =  self.descLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        self.addConstraints([leading, top, trailing, bottom])
    }
    
    func addConstrainsToImage() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading =  self.imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        let top =  self.imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        let height =  self.imgView.heightAnchor.constraint(equalToConstant: 100)
        let width =  self.imgView.widthAnchor.constraint(equalToConstant: 100)
        
        self.addConstraints([leading, top, height, width])
    }
}
