//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 李東一 on 2019/11/12.
//  Copyright © 2019 iru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var targetImage: UIButton!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var toggleButton: UIButton!
    
    private var images:[UIImage] = [UIImage(named: "sun")!, UIImage(named: "cloud")!, UIImage(named: "rain")!]
    private var index:Int = 0
    private var timer:Timer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scaleViewController:ScaleViewController = segue.destination as! ScaleViewController
        scaleViewController.image = images[index]
    }
    
    //次の画像セット（表示）
    private func setNextImage() {
        index = (index + 1) % 3
        targetImage.setImage(images[index], for: .normal)
    }
    
    //前の画像セット（表示）
    private func setPrevImage() {
        index = (index - 1 + images.count) % 3
        targetImage.setImage(images[index], for: .normal)
    }
    
    //画像スライドショー
    @objc private func changeImage() {
        setNextImage()
    }
    
    //画面が復帰した場合
    @IBAction func unwindVC(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }

    //スライドショーのON/OFF
    @IBAction func toggleSlideShowMode(_ sender: Any) {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            prevButton.isEnabled = false
            nextButton.isEnabled = false
            toggleButton.setImage(UIImage(named: "stop"), for: .normal)
        } else {
            timer.invalidate()
            timer = nil
            prevButton.isEnabled = true
            nextButton.isEnabled = true
            toggleButton.setImage(UIImage(named: "start"), for: .normal)
        }
    }
    
    //左ボタンアクション
    @IBAction func changePreviewImage(_ sender: Any) {
        setPrevImage()
    }
    
    //右ボタンアクション
    @IBAction func changeNextImage(_ sender: Any) {
        setNextImage()
    }
    
    //中央ボタンアクション
    @IBAction func showBigImage(_ sender: Any) {
        //スライドショー中に画像をタップした場合は止めた上で画面遷移
        if timer != nil {
            timer.invalidate()
            timer = nil
            prevButton.isEnabled = true
            nextButton.isEnabled = true
            toggleButton.setImage(UIImage(named: "start"), for: .normal)
        }
    }
    
}

