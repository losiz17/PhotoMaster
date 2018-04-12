//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 吉川莉央 on 2018/04/11.
//  Copyright © 2018年 RioYoshikawa. All rights reserved.
//

import UIKit
import Accounts

class ViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //カメラボタンを押した時に呼ばれる
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
    }
    
    //アルバムボタンを押した時に呼ばれる
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
    }
    func presentPickerController(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        //画像出力
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func drawText(image: UIImage) -> UIImage{
        let text = "Life is tech!"
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Arial", size: 120)!,
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x:0, y:0, width:image.size.width,height:image.size.height))
        
        let margin: CGFloat = 5.0
        let textRect = CGRect(x:margin, y:margin, width:image.size.width-margin, height:image.size.height-margin)
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage{
        let maskImage = UIImage(named: "furo_ducky")!
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x:0, y:0, width:image.size.width,height:image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x:image.size.width-maskImage.size.width-margin,
                              y:image.size.width-maskImage.size.width-margin,
                              width:maskImage.size.width, height:maskImage.size.height)
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    //テキスト合成
    @IBAction func onTappedTextButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawText(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    //イラスト合成
    @IBAction func onTappedIllustButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    //SNS
    @IBAction func onTappedUpLoadButton(){
        if photoImageView.image != nil{
            //共有するアイテムを設定
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#PhotoMaster"],
                                                      applicationActivities: nil)
            self.present(activityVC,animated:true, completion:nil)
            
        }else{
            print("画像がありません")
        }
    }
    

    
        
    

}

