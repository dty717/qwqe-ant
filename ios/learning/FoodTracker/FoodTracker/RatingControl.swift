//
//  RatingControl.swift
//  FoodTracker
//
//  Created by dty on 2018/10/1.
//  Copyright © 2018年 dty. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    @IBInspectable var starSize:CGSize=CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var startCount:Int=5{
        didSet{
            setupButtons()
        }
    }
    private var ratingButton=[UIButton]()
    
     var rating:Int = Int(1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    @objc func rateTap(button:UIButton) {
        button.backgroundColor=UIColor.black
        guard let rating_new=ratingButton.index(of: button)else{
            fatalError("The button \(button), is not in the rating");
            
        }
        print(rating,rating_new)
        updateButtonSelected(rating_new:rating_new);
    }
    private func updateButtonSelected(rating_new:Int){
        if(rating<rating_new){
            for i in rating+1...rating_new {
                ratingButton[i].isSelected=true;
            }
        }else if(rating>rating_new){
            for i in rating_new+1...rating {
                ratingButton[i].isSelected=false
            }
        }
        rating=rating_new;
    }
    private func setupButtons(){
        let bundle = Bundle(for: type(of: self))
        let filledStar=UIImage(named: "FilledStar",in:bundle,compatibleWith:self.traitCollection);
        let emptyStar=UIImage(named: "EmptyStar",in:bundle,compatibleWith:self.traitCollection);
        let highlightStar=UIImage(named: "HighlightStar",in:bundle,compatibleWith:self.traitCollection);

        
        for button in ratingButton{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButton.removeAll();
        for index in 0..<startCount {
            
            let button=UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightStar, for: .highlighted)
            button.setImage(highlightStar, for: [.highlighted, .selected])

            button.translatesAutoresizingMaskIntoConstraints=false;
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true;
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true;
            
            addArrangedSubview(button)
            button.addTarget(self, action: #selector(RatingControl.rateTap( button: )), for: .touchUpInside)
            //button.setValue(String.init(index),forKey:"index");
            //button.accessibilityIdentifier=String.init(index)
            ratingButton.append(button)
        }
        for i in 0..<1+rating{
            ratingButton[i].isSelected=true;
        }
        //updateButtonSelected(rating_new: 3)
        //updateButtonSelected(rating_new: 3);
    }
}
