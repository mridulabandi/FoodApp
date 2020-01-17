//
//  ViewController.swift
//  RiviFood
//
//  Created by mysmac_adm!n on 13/01/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit
import AlamofireImage



class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var HeadingLabel: UILabel!
    @IBOutlet weak var ViewScroll: UIView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var CollectionViewScroll: UICollectionView!
    @IBOutlet weak var PageControl: UIPageControl!
    
    var BoolState = true
    var SelectIndex = -1
    var ImageCount = 0
    var ImageArray :[String] = []
    var titleArr : [String] = []
    var aboutArr: [String] = []
    var DescArr : [String] = []
    var location: [String] = []
    var BestDishArr: [String] = []
    var Imageslist : [[String]] = []
    var testImages :[[String]] = []
    var SortData : [Int : Any] = [:]
    var output: [[String]] = []
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.LoadData()
        self.TableView.rowHeight = UITableView.automaticDimension
        self.TableView.estimatedRowHeight = 100
    }
    
    func loadCarosle()
    {
        PageControl.numberOfPages = ImageArray.count
        PageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    func LoadData()
    {
        FoodApiManager.getFoodDetails{
            (Response , Error) in
            guard let response = Response else { return }
            self.HeadingLabel.text = String((response.data?.card_details!.title)!) + " " + String((response.data?.card_details!.city)!)
          
            for i in (response.data?.card!)!
            {
                self.ImageCount = self.ImageCount + 1
                self.ImageArray.append(i.img!)
                self.titleArr.append(i.title!)
                self.DescArr.append(i.desc!)
                
                var str1 = ""
                var count1 = 0
                for about in i.details!.about!
                {
                    count1 = count1 + 1
                    str1.append( about + "\n")
                }
               self.aboutArr.append(str1)
                
                var str = ""
                var count = 0
                for place in (i.details?.location!)!
                {
                    count = count + 1
                    if place.distance != nil
                    {str.append( String(count) + "  " + place.name! + " (" + String(place.distance!) + "km from city centre)" +  "\n")}
                   }
                self.location.append(str)
                
                var str2 = ""
                var count2 = 0
                for dish in i.details!.dishes!
                {
                    count2 = count2 + 1
                    str2.append( String(count2) + "  " + dish + "\n")
                }
                self.BestDishArr.append(str2)
                
                var tempimg : [String] = []
                for image in i.details!.images!
                {
                    tempimg.append(image)
                }
                self.Imageslist.append(tempimg)
                
            }
            
            print(self.ImageArray)
            
            var count: Int = 0
            for i in self.Imageslist {
                if i.count > count {
                    count = i.count
                }
            }
            var index: Int!
            for i in 0..<count {
                index = i
                var element = Array<String>()
                for j in self.Imageslist {
                    if j.count > index {
                        element.append(j[index])
                    } else {
                        element.append("")
                    }
                }
                self.output.append(element)
            }
            self.TableView.reloadData()
            self.CollectionViewScroll.reloadData()
            self.loadCarosle()
        }
    }
    
    @objc func changeImage() {
       
       if counter < ImageArray.count {
           let index = IndexPath.init(item: counter, section: 0)
        self.CollectionViewScroll.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
           PageControl.currentPage = counter
           counter += 1
       } else {
           counter = 0
           let index = IndexPath.init(item: counter, section: 0)
           self.CollectionViewScroll.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
           PageControl.currentPage = counter
           counter = 1
       }
           
       }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ImageCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if self.SelectIndex == indexPath.row && BoolState
        {
            return 500
        }
        else
        {
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailTableViewCell", for: indexPath) as! FoodDetailTableViewCell

        if self.titleArr.count > 0
        {cell.foodname?.text = self.titleArr[indexPath.row]}
        
        if self.ImageArray.count > 0
        {let url = URL(string: self.ImageArray[indexPath.row])
            cell.mainImage.load(url: url!)}
        cell.mainImage.layer.cornerRadius = 15
        
        
        if self.DescArr.count > 0
        {cell.describtion.text = self.DescArr[indexPath.row]}
        
        if self.aboutArr.count > 0
        {cell.About.text = self.aboutArr[indexPath.row]}
        
        if self.location.count > 0
        {cell.whereToEat.text = self.location[indexPath.row]}
        
        if self.BestDishArr.count > 0
        {cell.BestDishes.text = self.BestDishArr[indexPath.row]}
        
        if self.output.count > 0
        {
           let url = URL(string: self.output[0][indexPath.row])
            if url != nil
            { cell.Image1.load(url: url!)}
            cell.Image1.layer.cornerRadius = 20
            
            let url1 = URL(string: self.output[1][indexPath.row])
            if url1 != nil
            { cell.Image2.load(url: url1!)}
            cell.Image2.layer.cornerRadius = 20
           
            
            let url2 = URL(string: self.output[2][indexPath.row])
            if url2 != nil
            {cell.Image3.load(url: url2!)}
            cell.Image3.layer.cornerRadius = 20
            
            let url3 = URL(string: self.output[3][indexPath.row])
            if url3 != nil
            { cell.Image4.load(url: url3!)}
             cell.Image4.layer.cornerRadius = 20
         }
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if SelectIndex == indexPath.row
        {
            if self.BoolState == false
            {self.BoolState = true}
            else
            {self.BoolState = false}
        }
        else
        { self.BoolState = true }
        self.SelectIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
     
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(1) as? UIImageView
        {
            let url = URL(string: ImageArray[indexPath.row])
            if url != nil
            {
                vc.af_setImage(withURL: url!)}
            vc.layer.cornerRadius = 15
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
