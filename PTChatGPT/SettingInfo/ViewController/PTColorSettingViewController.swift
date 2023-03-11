//
//  PTColorSettingViewController.swift
//  PTChatGPT
//
//  Created by 邓杰豪 on 9/3/23.
//  Copyright © 2023 SexyBoy. All rights reserved.
//

import UIKit
import PooTools
import ChromaColorPicker

class PTColorSettingViewController: PTChatBaseViewController {

    let colorPicker = ChromaColorPicker()
    let brightnessSlider = ChromaBrightnessSlider()
    var userBubbleHandle = ChromaColorHandle()
    var botBubbleHandle = ChromaColorHandle()
    var userTextHandle = ChromaColorHandle()
    var botTextHandle = ChromaColorHandle()

    lazy var userBubbleInfo:BKLayoutButton = {
        return self.createImageInfo(image: UIImage(systemName: "bubble.left.fill")!.withRenderingMode(.automatic), info: PTLanguage.share.text(forKey: "color_Bubble_user"))
    }()
    
    lazy var botBubbleInfo:BKLayoutButton = {
        return self.createImageInfo(image: UIImage(systemName: "bubble.right.fill")!.withRenderingMode(.automatic), info: PTLanguage.share.text(forKey: "color_Bubble_bot"))
    }()
    
    lazy var userTextInfo:BKLayoutButton = {
        return self.createImageInfo(image: UIImage(systemName: "plus.bubble.fill")!.withRenderingMode(.automatic), info: PTLanguage.share.text(forKey: "color_Text_user"))
    }()

    lazy var botTextInfo:BKLayoutButton = {
        return self.createImageInfo(image: UIImage(systemName: "text.bubble.fill")!.withRenderingMode(.automatic), info: PTLanguage.share.text(forKey: "color_Text_bot"))
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.zx_navTitle = PTLanguage.share.text(forKey: "color_Setting")
        self.setupColorPicker()
        self.setupBrightnessSlider()
        self.setupColorPickerHandles()
        
        let backBtn = UIButton.init(type: .custom)
        backBtn.setImage(UIImage(systemName: "chevron.left")!.withTintColor(.gobalTextColor, renderingMode: .automatic), for: .normal)
        backBtn.bounds = CGRect.init(x: 0, y: 0, width: 24, height: 24)
        backBtn.addActionHandlers { seder in
            self.returnFrontVC()
        }
        self.zx_navBar?.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(34)
            make.left.equalToSuperview().inset(PTAppBaseConfig.share.defaultViewSpace)
            make.bottom.equalToSuperview()
        }
        
        
        self.view.addSubviews([self.colorPicker,self.brightnessSlider,self.userBubbleInfo,self.botBubbleInfo,self.userTextInfo,self.botTextInfo])
        self.colorPicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(self.colorPicker.snp.width)
            make.top.equalToSuperview().inset(CGFloat.kNavBarHeight_Total + 10)
        }
        self.brightnessSlider.snp.makeConstraints { make in
            make.left.right.equalTo(self.colorPicker)
            make.height.equalTo(28)
            make.top.equalTo(self.colorPicker.snp.bottom).offset(20)
        }
        
        self.userBubbleInfo.snp.makeConstraints { make in
            make.left.right.equalTo(self.brightnessSlider)
            make.top.equalTo(self.brightnessSlider.snp.bottom).offset(10)
        }
        
        self.botBubbleInfo.snp.makeConstraints { make in
            make.left.right.equalTo(self.brightnessSlider)
            make.top.equalTo(self.userBubbleInfo.snp.bottom).offset(10)
        }

        self.userTextInfo.snp.makeConstraints { make in
            make.left.right.equalTo(self.brightnessSlider)
            make.top.equalTo(self.botBubbleInfo.snp.bottom).offset(10)
        }
        
        self.botTextInfo.snp.makeConstraints { make in
            make.left.right.equalTo(self.brightnessSlider)
            make.top.equalTo(self.userTextInfo.snp.bottom).offset(10)
        }

    }
    
    func setupColorPicker()
    {
        self.colorPicker.delegate = self
        self.colorPicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupBrightnessSlider() {
        self.brightnessSlider.connect(to: self.colorPicker)
        self.brightnessSlider.trackColor = UIColor.blue
        self.brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupColorPickerHandles()
    {
        self.userBubbleHandle = self.colorPicker.addHandle(at: AppDelegate.appDelegate()!.appConfig.userBubbleColor)
        let userBubbleImageView = UIImageView(image: UIImage(systemName: "bubble.left.fill")?.withRenderingMode(.automatic))
        userBubbleImageView.contentMode = .scaleAspectFit
        userBubbleImageView.tintColor = .white
        self.userBubbleHandle.accessoryView = userBubbleImageView
        self.userBubbleHandle.accessoryViewEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)
        
        self.botBubbleHandle = self.colorPicker.addHandle(at: AppDelegate.appDelegate()!.appConfig.botBubbleColor)
        let botBubbleImageView = UIImageView(image: UIImage(systemName: "bubble.right.fill")?.withRenderingMode(.alwaysTemplate))
        botBubbleImageView.contentMode = .scaleAspectFit
        botBubbleImageView.tintColor = .white
        self.botBubbleHandle.accessoryView = botBubbleImageView
        self.botBubbleHandle.accessoryViewEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)
        
        self.userTextHandle = self.colorPicker.addHandle(at: AppDelegate.appDelegate()!.appConfig.userTextColor)
        let userTextImageView = UIImageView(image: UIImage(systemName: "plus.bubble.fill")?.withRenderingMode(.alwaysTemplate))
        userTextImageView.contentMode = .scaleAspectFit
        userTextImageView.tintColor = .white
        self.userTextHandle.accessoryView = userTextImageView
        self.userTextHandle.accessoryViewEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)

        self.botTextHandle = self.colorPicker.addHandle(at: AppDelegate.appDelegate()!.appConfig.botTextColor)
        let botTextImageView = UIImageView(image: UIImage(systemName: "text.bubble.fill")?.withRenderingMode(.alwaysTemplate))
        botTextImageView.contentMode = .scaleAspectFit
        botTextImageView.tintColor = .white
        self.botTextHandle.accessoryView = botTextImageView
        self.botTextHandle.accessoryViewEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)
    }
    
    func createImageInfo(image:UIImage,info:String)->BKLayoutButton
    {
        let view = BKLayoutButton()
        view.setImage(image, for: .normal)
        view.layoutStyle = .leftImageRightTitle
        view.setMidSpacing(CGFloat.ScaleW(w: 5))
        view.setImageSize(CGSize(width: 18, height: 15))
        view.titleLabel?.font = .appfont(size: 14)
        view.setTitleColor(.gobalTextColor, for: .normal)
        view.setTitle(info, for: .normal)
        view.isUserInteractionEnabled = false
        return view
    }
}

extension PTColorSettingViewController:ChromaColorPickerDelegate
{
    func colorPickerHandleDidChange(_ colorPicker: ChromaColorPicker, handle: ChromaColorHandle, to color: UIColor) {
        if handle == self.botBubbleHandle
        {
            AppDelegate.appDelegate()?.appConfig.botBubbleColor = color
        }
        else if handle == self.userBubbleHandle
        {
            AppDelegate.appDelegate()?.appConfig.userBubbleColor = color
        }
        else if handle == self.userTextHandle
        {
            AppDelegate.appDelegate()?.appConfig.userTextColor = color
        }
        else if handle == self.botTextHandle
        {
            AppDelegate.appDelegate()?.appConfig.botTextColor = color
        }

    }
}
