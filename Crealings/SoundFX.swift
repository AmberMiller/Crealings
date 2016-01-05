//
//  SoundFX.swift
//  Crealings
//
//  Created by Amber Miller on 3/10/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import AVFoundation

class SoundFX {
    
    /* Sound Variables */
    var fxAudioPlayer = AVAudioPlayer();
    var soundsVolume = Float();
    let tapEgg = NSBundle.mainBundle().URLForResource("eggDrop", withExtension: "wav");
    let triangle = NSBundle.mainBundle().URLForResource("triangle", withExtension: "wav");
    
    func playTapEgg () {
        fxAudioPlayer = AVAudioPlayer(contentsOfURL: tapEgg, error: nil);
        //    fxAudioPlayer.volume = soundsVolume;
        fxAudioPlayer.play();
    }
    
    func playTriangle () {
        fxAudioPlayer = AVAudioPlayer(contentsOfURL: triangle, error: nil);
        fxAudioPlayer.play();
    }

}