//
//  ViewController.swift
//  LKLocalization
//
//  Created by Leela Prasad on 18/05/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var chngLangLbl: UIButton!
  
  
  let usrDeflts = UserDefaults.standard

  
  let availableLanguages = Localize.availableLanguages()
  var actionSheet: UIAlertController!


  override func viewDidLoad() {
    super.viewDidLoad()
    
    UserDefaults.standard.register(defaults: [String : Any]())
    
    
    
    self.setText()
  }
  
  func appThemeSetBySettingsPreference() {
    
    let theme = usrDeflts.string(forKey: "theme_preference")
    
    if theme == "dark" {
      
      view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
      
    } else {
      
      view.backgroundColor = #colorLiteral(red: 1, green: 0.9818309766, blue: 0.8050295814, alpha: 1)
    }
    
    
  }
  
  
  
 
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    appThemeSetBySettingsPreference()
    
    NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
   // NotificationCenter.default.removeObserver(self)
  }
  
  @objc func setText(){
    welcomeLabel.text = "Press Back Button to go back".localized()
    chngLangLbl.setTitle("Change Language".localized(), for: .normal)
  }
  
  
  
  @IBAction func onChangeLangPressed(_ sender: UIButton) {
    
    changeLanguage()
    
  }
  
  
  
  
  
  
  func changeLanguage() {
    
    actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertControllerStyle.actionSheet)
    for language in availableLanguages {
      let displayName = Localize.displayNameForLanguage(language)
      let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
        (alert: UIAlertAction!) -> Void in
        Localize.setCurrentLanguage(language)
      })
      actionSheet.addAction(languageAction)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
      (alert: UIAlertAction) -> Void in
    })
    actionSheet.addAction(cancelAction)
    self.present(actionSheet, animated: true, completion: nil)
    
  }
  


}

