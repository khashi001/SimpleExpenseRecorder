//
//  FirstViewController.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/06.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource  {
    
    
    @IBOutlet weak var collectionViewHaha: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewHaha.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = UIColor.blue()
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewHaha.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

