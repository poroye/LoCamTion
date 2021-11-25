//
//  ViewController.swift
//  LoCamTion
//
//  Created by ธนัท แสงเพิ่ม on 24/11/2564 BE.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var allItems: Results<Item>?{
        didSet{
            collection.reloadData()
        }
    }
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        allItems = realm.objects(Item.self)
//        print(items)
        
    }

    @IBAction func addImagePressed(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        print(image.size)
        
        let data = NSData(data: image.pngData()!)
        
        let newItem = Item()
        newItem.imgData = data
        newItem.lat = "fake lat"
        newItem.lon = "fake long"
        
        do{
            try realm.write{
                realm.add(newItem)
                self.collection.reloadData()
            }
        } catch {
            print("realm fail >> \(error)")
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("have \(allItems?.count) cell")
        return allItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as? imgCell {
//        cell.img.image = UIImage(data: (allItems?[indexPath.row].imgData!)! as Data )!
//            customCell.img.image = UIImage(named: "testImage")
            customCell.img.image = UIImage(data: (allItems?[indexPath.row].imgData!)! as Data )
            cell = customCell
        }
        return cell
    }
    
    
}
