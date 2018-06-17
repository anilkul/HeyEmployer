//
//  ViewController.swift
//  Scriber
//
//  Created by Mehmet Anıl Kul on 23.09.2017.
//  Copyright © 2017 Mehmet Anıl Kul. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    //audio playeri tanimlayalim
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // activity spinner butona basilmadigi durumda devre disi
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        
        //Authorization istiyoruz
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            // Eger Authorization basarili olursa
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                // ses dosyamizin yolunu belirten bir path degiskenini bundle ile gosteriyoruz
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        // AVAudioPlayer ile dosya yolunu gosterip ses dosyamizi almayi deniyoruz.
                        let sound = try AVAudioPlayer(contentsOf: path)
                        
                        // tanimladigimiz audio player'i ses dosyamiza atiyoruz
                        self.audioPlayer = sound
                        
                        // delegete protokolunu aktive ediyoruz
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        // try'dan sonra hata alirsak yazdiriyoruz
                        print("Error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    // 2 output alabiliriz sonuc veya hata
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        // hata varsa goster
                        if let error = error {
                            print("There was an error: \(error)")
                        //yoksa yaziyi goster
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    
    // Audio Player'i durdur
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // AP'i durdurduk
        player.stop()
        //Activity Spinner'i durdurduk ve gizledik
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    // Play butonuna basinca
    @IBAction func playBtnPressed(_ sender: Any) {
        // Activity Spinner gorunur halde ve donuyor
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        // Speech API kullanilsin mi?
        requestSpeechAuth()
    }
}

